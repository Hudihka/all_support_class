

import UIKit
import Metal //начинаем с импорта библиотечки

class ViewController: UIViewController {

  let vertexData:[Float] = [0.0, 1.0, 0.0, // массив с кординатами вершин, все в метталле по умолчанию треугольник
                            -1.0, -1.0, 0.0,
                            1.0, -1.0, 0.0]


  //1.2 Интерфейс Metal для GPU, который вы используете для рисования графики или параллельных вычислений.
  var device: MTLDevice!

  //2.1 По сути эо наследник обычного класса CALayer
  //с той лиш разницей что это спец слой для метталла
  var metalLayer: CAMetalLayer!

  //3,1 Ресурс, который хранит данные в формате, определенном вашим приложением.
  //Металлический каркас ничего не знает о содержимом MTLBuffer, только его размер.
  //Вы определяете формат данных в буфере и убедитесь,
  //что ваше приложение и ваши шейдеры знают, как читать и записывать данные.
  //Например, вы можете создать структуру в своем шейдере,
  //которая определяет данные, которые вы хотите сохранить в буфере, и его структуру памяти.
  var vertexBuffer: MTLBuffer!

  //6.1
  //специальный объект, называемый конвейером рендеринга
  //рендеринга - отрисовка
  //MTLRenderPipelineState - Объект, который содержит графические функции и состояние конфигурации, используемые на этапе рендеринга
  var pipelineState: MTLRenderPipelineState!

  //7.1 просто очередь команд необходимых для рейлинга
  var commandQueue: MTLCommandQueue!


  //отрисовка.1
  //ничинаем рисовать
  //это класс представляет собой таймер, который срабатывае каждый раз при перерисовке экрана
  //те 40-60 раз в секунду
  var timer: CADisplayLink!


  override func viewDidLoad() {
    super.viewDidLoad()

    //1.3
    //Возвращает ссылку на предпочтительный объект устройства Metal по умолчанию.
    //так же можно получиь все обьекты
    device = MTLCreateSystemDefaultDevice()

    //2.2
    metalLayer = CAMetalLayer()             // создание слоя
    metalLayer.device = device              // указание что слой принадлежит нашему девайсу
    metalLayer.pixelFormat = .bgra8Unorm    // цветовой формат слоя, в данном случае 8 битный по аналогии со страокой ниже
                                            // UIColor(red: 200/256, green: 10/256, blue: 150/256, alpha: 0.8)
    metalLayer.framebufferOnly = true       // использавание слоя только для отрисовки(ставим фолз если нужно ьрать образцы
                                            // текстур отрисованных спец для этого слоя)
    metalLayer.frame = view.layer.frame     // размеры слоя и добавление его на вью
    view.layer.addSublayer(metalLayer)

    //3,2 Заполнение буффера
    //определяем размерр датты, это колличесттво кординат умноженное на вес каждой кординаты
    //где MemoryLayout.size это размер памяти в байттах

    let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])

    // 3,3 определяем наш буффер
    // говорим что данные у нашего девайса буффер имеетт ттакие размеры
    // options говорит о ттом как будут использовать этти данные цпу и гпу,
    //где хранится резервная копия и как она обновляеся в случае изменения vertexData

    vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options: [])

    // 6.2 загрузка Из файла SRADER.metall вершин и фрагментов между ними
    let defaultLibrary = device.makeDefaultLibrary()!
    let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
    let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")

    // 6.3
    // MTLRenderPipelineDescriptor опмсание
    //Аргумент параметров, передаваемых устройству для получения объекта состояния конвейера рендеринга.
    //некий мост между девайсом и pipelineState
    let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
    pipelineStateDescriptor.vertexFunction = vertexProgram // задаем вершиины
    pipelineStateDescriptor.fragmentFunction = fragmentProgram // задаем фрагменты
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm //формат цвета

    // 6.4 компилируете конфигурацию конвейера в состояние конвейера, которое эффективно использовать здесь и далее.
    self.pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)

    commandQueue = device.makeCommandQueue()   //7.2 очередь команд

    //отрисовка.1
    //запускаем таймер и задаем настройки
    timer = CADisplayLink(target: self, selector: #selector(gameloop))
    //RunLoop.main значи вызывается на основном потоке
    //надо быть осторожным при задании поока
    // forMode: это значение должно быть для иос по умолчанию .default
    //другие значения нужны для mac os
    timer.add(to: RunLoop.main, forMode: .default)
  }

  func render() {
    //берем у слоя сл отрисовку
    guard let drawable = metalLayer?.nextDrawable() else { return }

    //Объект содержит коллекцию вложений ,
    //которые являются местом рендеринга для пикселов, генерируемого рендеринг проходом.

    //в данной ситуации нам нужет первый эллемент colorAttachments
    //настраиваем этот цвет

    let renderPassDescriptor = MTLRenderPassDescriptor()
    //задаем тексуру
    //очищаем ее и задаем фон
    renderPassDescriptor.colorAttachments[0].texture = drawable.texture
    renderPassDescriptor.colorAttachments[0].loadAction = .clear  //очищаем
    renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 55.0/255.0, alpha: 1.0) //задаем фон

    //отрисовка.3
    //ну собственно задаем команды для рейдеринга в буффере

    let commandBuffer = commandQueue.makeCommandBuffer()

    //отрисовка.4

    //создаем команду на основе входных данных о цвете итд
    let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)

    //мы берем наше состояние наш конвеер команд
    renderEncoder?.setRenderPipelineState(pipelineState)
    //задаем буффер
    renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
    //рисуем треугольник .triangle
    renderEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
    renderEncoder?.endEncoding()

    commandBuffer?.present(drawable)
    commandBuffer?.commit()
  }

  @objc func gameloop() {
    // обновление происходит постоянно, значит зацикливания не будет c autoreleasepool
    //тк если какой то обьект буде схвачен сильной ссылкой то милионы обьектов остануься в памяти
    autoreleasepool {
      self.render()
    }
  }

}
