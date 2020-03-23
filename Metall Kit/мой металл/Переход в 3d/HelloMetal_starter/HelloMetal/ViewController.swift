

import UIKit
import Metal

class ViewController: UIViewController {

  var objectToDraw: Triangle!


  var device: MTLDevice!                      //1.2
  var metalLayer: CAMetalLayer!               //2.1
  var vertexBuffer: MTLBuffer? = nil                //3.1
  var commandQueue: MTLCommandQueue!          //7.1
  var pipelineState: MTLRenderPipelineState!  //6.1

  var timer: CADisplayLink! //отрисовка.1


  override func viewDidLoad() {
    super.viewDidLoad()

    device = MTLCreateSystemDefaultDevice()//1.3

    //2.2
    metalLayer = CAMetalLayer ()            // создание слоя
    metalLayer.device = device              // указание что слой принадлежит нашему девайсу
    metalLayer.pixelFormat = .bgra8Unorm    // цветовой формат слоя, в данном случае 8 битный по аналогии со страокой ниже
                                            // UIColor(red: 200/256, green: 10/256, blue: 150/256, alpha: 0.8)
    metalLayer.framebufferOnly = true       // использавание слоя только для отрисовки(ставим фолз если нужно ьрать образцы
                                            // текстур отрисованных спец для этого слоя)
    metalLayer.frame = view.layer.frame     // размеры слоя и добавление его на вью
    view.layer.addSublayer(metalLayer)

    objectToDraw = Triangle(device: device)

    // 6.2 загрузка Из файла SRADER.metall вершин и фрагментов между ними
    let defaultLibrary = device.makeDefaultLibrary()!
    let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
    let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")

    // 6.3
    let pipelineStateDescriptor = MTLRenderPipelineDescriptor() //Аргумент параметров, передаваемых устройству
    //для получения объекта состояния конвейера рендеринга.
    pipelineStateDescriptor.vertexFunction = vertexProgram
    pipelineStateDescriptor.fragmentFunction = fragmentProgram
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm //формат цвета

    // 6.4 компилируете конфигурацию конвейера в состояние конвейера, которое эффективно использовать здесь и далее.
    self.pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)

    commandQueue = device.makeCommandQueue()   //7.2 очередь команд

    //отрисовка.1
    timer = CADisplayLink(target: self, selector: #selector(gameloop))
    timer.add(to: RunLoop.main, forMode: .default)
  }

  func render() {
    guard let drawable = metalLayer?.nextDrawable() else { return }
    objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, clearColor: nil)
  }

  @objc func gameloop() {
    autoreleasepool { // обновление происходит постоянно, значит зацикливания не будет
      self.render()
    }
  }

}
