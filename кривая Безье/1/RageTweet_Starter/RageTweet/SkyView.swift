

import UIKit

class SkyView: UIView {
  private var rageLevel: RageLevel = .happy

  func setRageLevel(_ rageLevel: RageLevel) {
    self.rageLevel = rageLevel
    setNeedsDisplay()
  }
  
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }

    let colorSpace = CGColorSpaceCreateDeviceRGB()

      drawSky(in: rect, context: context, colorSpace: colorSpace) /*рисуем небо*/
      drawMountains(in: rect, in: context, with: colorSpace) /*рисуем горы*/
      drawGrass(in: rect, in: context, with: colorSpace)
      drawFlowers(in: rect, in: context, with: colorSpace)
  }
  
  //MARK: - РИСУЕМ НЕБО
  
  private func drawSky(in rect: CGRect,
                       context: CGContext,
                       colorSpace: CGColorSpace?) {
    /*
     
     сохраняем графическое состояние. Вы должны всегда
     делать это, когда вы собираетесь рисовать.
     Также обязательно восстановите состояние, когда закончите рисовать.
     Вы можете сделать это, когда метод завершается с помощью defer.
     
     */
    context.saveGState()
    defer { context.restoreGState() }

    // рисуем градиент из 3Х частей
    let baseColor = UIColor(red: 148.0 / 255.0, green: 158.0 / 255.0,
                            blue: 183.0 / 255.0, alpha: 1.0)
    let middleStop = UIColor(red: 127.0 / 255.0, green: 138.0 / 255.0,
                             blue: 166.0 / 255.0, alpha: 1.0)
    let farStop = UIColor(red: 96.0 / 255.0, green: 111.0 / 255.0,
                          blue: 144.0 / 255.0, alpha: 1.0)

    let gradientColors = [baseColor.cgColor, middleStop.cgColor, farStop.cgColor]
    let locations: [CGFloat] = [0.0, 0.1, 0.25]

    guard let gradient = CGGradient(colorsSpace: colorSpace,
                                    colors: gradientColors as CFArray,
                                    locations: locations) else {
        return
    }

    // 3
    let startPoint = CGPoint(x: rect.size.height / 2, y: 0)
    let endPoint = CGPoint(x: rect.size.height / 2, y: rect.size.width)
    context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
  }

  
  //MARK: - РИСУЕМ ГОРЫ
  
  private func drawMountains(in rect: CGRect,      //рисуем горы
                             in context: CGContext,
                             with colorSpace: CGColorSpace?) {
    
    let darkColor = UIColor(red: 1.0 / 255.0, green: 93.0 / 255.0,
                            blue: 67.0 / 255.0, alpha: 1)
    let lightColor = UIColor(red: 63.0 / 255.0, green: 109.0 / 255.0,
                             blue: 79.0 / 255.0, alpha: 1)
    let rectWidth = rect.size.width

    let mountainColors = [darkColor.cgColor, lightColor.cgColor]
    let mountainLocations: [CGFloat] = [0.1, 0.2]
    
    guard let mountainGrad = CGGradient.init(colorsSpace: colorSpace,
                                             colors: mountainColors as CFArray,
                                             locations: mountainLocations) else {
           return
    }

    let mountainStart = CGPoint(x: rect.size.height / 2, y: 100)
    let mountainEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)

    context.saveGState()
    defer { context.restoreGState() }

    // квадратная кривая
    
    let backgroundMountains = CGMutablePath()
    backgroundMountains.move(to: CGPoint(x: -5, y: 157), transform: .identity) //начало кривой
    backgroundMountains.addQuadCurve(to: CGPoint(x: 77, y: 157),  //конец кривой
                                     control: CGPoint(x: 30, y: 129), //магнит
                                     transform: .identity)
    
    //кривая безье
    
    backgroundMountains.addCurve(to: CGPoint(x: 303, y: 125),       //Это указывает на конец строки
                                 control1: CGPoint(x: 190, y: 210), //Это указывает на положение первого магнита
                                 control2: CGPoint(x: 200, y: 70),  //Это указывает на положение второго магнита
                                 transform: .identity)

    
    
    backgroundMountains.addQuadCurve(to: CGPoint(x: 350, y: 150),
                                     control: CGPoint(x: 340, y: 150),
                                     transform: .identity)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 410, y: 145),
                                     control: CGPoint(x: 380, y: 155),
                                     transform: .identity)
    backgroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 165),
                                 control1: CGPoint(x: rectWidth - 90, y: 100),
                                 control2: CGPoint(x: rectWidth - 50, y: 190),
                                 transform: .identity)
    
    
    backgroundMountains.addLine(to: CGPoint(x: rectWidth - 10, y: rect.size.width),
                                transform: .identity)
    backgroundMountains.addLine(to: CGPoint(x: -5, y: rect.size.width),
                                transform: .identity)
    backgroundMountains.closeSubpath()
    
    

    // Фоновый рисунок горы
    context.addPath(backgroundMountains)
    context.clip() //отсекаем область для которой будет градиент
    context.drawLinearGradient(mountainGrad, //добавляем градиент
                               start: mountainStart,
                               end: mountainEnd, options: [])
    context.setLineWidth(4)

    
    // рисуем кривую
    context.addPath(backgroundMountains)
    context.setStrokeColor ( UIColor.black.cgColor)
    context.strokePath()

    
    // русуем еще горы
    let foregroundMountains = CGMutablePath()
    foregroundMountains.move(to: CGPoint(x: -5, y: 190),
                             transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: 303, y: 190),
                                 control1: CGPoint(x: 160, y: 250),
                                 control2: CGPoint(x: 200, y: 140),
                                 transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 210),
                                 control1: CGPoint(x: rectWidth - 150, y: 250),
                                 control2: CGPoint(x: rectWidth - 50, y: 170),
                                 transform: .identity)
    foregroundMountains.addLine(to: CGPoint(x: rectWidth, y: 230),
                                transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: -5, y: 225),
                                 control1: CGPoint(x: 300, y: 260),
                                 control2: CGPoint(x: 140, y: 215),
                                 transform: .identity)
    foregroundMountains.closeSubpath()

    context.addPath(foregroundMountains)
    context.clip()
    context.setFillColor(darkColor.cgColor)
    context.fill(CGRect(x: 0, y: 170, width: rectWidth, height: 90))//наложенная область которую заливаем

    // Foreground Mountain stroking
    context.addPath(foregroundMountains)
    context.setStrokeColor(UIColor.black.cgColor)//цвет линии
    context.strokePath()



  }
  
  
  
  //MARK: - РИСУЕМ ТРАВУ
  
  private func drawGrass(in rect: CGRect, in context: CGContext,
                         with colorSpace: CGColorSpace?) {
    // 1
    context.saveGState()
    defer { context.restoreGState() }

    // 2
    let grassStart = CGPoint(x: rect.size.height / 2, y: 100)
    let grassEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)
    let rectWidth = rect.size.width

    let grass = CGMutablePath()
    grass.move(to: CGPoint(x: rectWidth, y: 230),
               transform: .identity)
    
    grass.addCurve(to: CGPoint(x: 0, y: 225),
                   control1: CGPoint(x: 300, y: 260),
                   control2: CGPoint(x: 140, y: 215),
                   transform: .identity)
    
    //это точки глубоко в низу, нужны для того что бы просто сделать прямоугольник
    //где верхняя часть будет волной
    grass.addLine(to: CGPoint(x: 0, y: rect.size.width),
                  transform: .identity)
    grass.addLine(to: CGPoint(x: rectWidth, y: rect.size.width),
                  transform: .identity)

    context.addPath(grass)
    context.clip()

    // 3
    let lightGreen = UIColor(red: 39.0 / 255.0, green: 171.0 / 255.0,
                             blue: 95.0 / 255.0, alpha: 1)

    let darkGreen = UIColor(red: 0.0 / 255.0, green: 134.0 / 255.0,
                            blue: 61.0 / 255.0, alpha: 1)

    let grassColors = [lightGreen.cgColor, darkGreen.cgColor]
    let grassLocations: [CGFloat] = [0.3, 0.4]
    if
      let grassGrad = CGGradient.init(colorsSpace: colorSpace,
      colors: grassColors as CFArray, locations: grassLocations) {
        context.drawLinearGradient(grassGrad, start: grassStart,
                                   end: grassEnd, options: [])
    }
  }


  //MARK: - РИСОВАНИЕ ЦВЕТКА
  
  //переводим градусы в радианы
  private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees/180.0
  }

  //рисуем элипс в прямоугольнике
  private func drawPetal(in rect: CGRect,
                         inDegrees degrees: Int, //поворачиваемм на угол
                         inContext context: CGContext) {
    // 1
    context.saveGState()
    defer { context.restoreGState() }

    // 2
    let midX = rect.midX
    let midY = rect.midY
    let angleRadians = degreesToRadians(CGFloat(degrees))
    
    //меняем началььные параметры что бы можно было проще повернуть
    //concatenating это обединение трансформов
    let transform = CGAffineTransform(translationX: -midX, y: -midY) //двигаем точку Х в низ и лево
      .concatenating(CGAffineTransform(rotationAngle: angleRadians)) //поворачиваем
      .concatenating(CGAffineTransform(translationX: midX, y: midY)) //возвращаем в начальную позицию

    let flowerPetal = CGMutablePath()
    flowerPetal.addEllipse(in: rect, transform: transform) //рисуем элипс в области
    context.addPath(flowerPetal)                           //добавляем элипс
    context.setStrokeColor(UIColor.black.cgColor)          //цвет границ
    context.strokePath()                                   //рисуем линию вдоль пути
    context.setFillColor(UIColor.white.cgColor)            //цвет содержиммого
    context.addPath(flowerPetal)
    context.fillPath() //Окрашивает область в пределах текущего пути в соответствии с заданным правилом заливки
  }
  
  
  // рисуем сам цветок
  
  
  /*
  private func drawFlowers(in rect: CGRect, in context: CGContext,
                           with colorSpace: CGColorSpace?) {
    // 1
    context.saveGState()
    defer { context.restoreGState() }

    // рисуем лепестки
    drawPetal(in: CGRect(x: 125, y: 230, width: 9, height: 14),
              inDegrees: 0, inContext: context)
    drawPetal(in: CGRect(x: 115, y: 236, width: 10, height: 12),
              inDegrees: 300, inContext: context)
    drawPetal(in: CGRect(x: 120, y: 246, width: 9, height: 14),
              inDegrees: 5, inContext: context)
    drawPetal(in: CGRect(x: 128, y: 246, width: 9, height: 14),
              inDegrees: 350, inContext: context)
    drawPetal(in: CGRect(x: 133, y: 236, width: 11, height: 14),
              inDegrees: 80, inContext: context)

    // рисуем центр
    let center = CGMutablePath()
    let ellipse = CGRect(x: 126, y: 242, width: 6, height: 6)
    center.addEllipse(in: ellipse, transform: .identity)

    let orangeColor = UIColor(red: 255 / 255.0, green: 174 / 255.0,
                              blue: 49.0 / 255.0, alpha: 1.0)

    context.addPath(center)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()
    context.setFillColor(orangeColor.cgColor)
    context.addPath(center)
    context.fillPath()

    // рисуем стебель
    context.move(to: CGPoint(x: 135, y: 249))
    context.setStrokeColor(UIColor.black.cgColor)
    context.addQuadCurve(to: CGPoint(x: 133, y: 270), control: CGPoint(x: 145, y: 250))
    context.strokePath()
  }

*/
  
  /*
   метод что выше - это по сути рисование одного цветка
   что ниже рисование сразу группы цветов
  
   */
  
  private func drawFlowers(in rect: CGRect,
                           in context: CGContext,
                           with colorSpace: CGColorSpace?) {
    context.saveGState()
    defer { context.restoreGState() }

    // Установите размер объекта, который вы рисуете.
    let flowerSize = CGSize(width: 300, height: 300)

    // Создайте новый слой, передав текущий графический контекст.
    guard let flowerLayer = CGLayer(context,
                                    size: flowerSize,
                                    auxiliaryInfo: nil) else {
      return
    }

    // Извлеките графический контекст слоя. С этого момента вы рисуете контекст слоя вместо основного графического контекста.
    guard let flowerContext = flowerLayer.context else {
      return
    }

    // рисуем лепестки
    drawPetal(in: CGRect(x: 125, y: 230, width: 9, height: 14), inDegrees: 0,
              inContext: flowerContext)
    drawPetal(in: CGRect(x: 115, y: 236, width: 10, height: 12), inDegrees: 300,
              inContext: flowerContext)
    drawPetal(in: CGRect(x: 120, y: 246, width: 9, height: 14), inDegrees: 5,
              inContext: flowerContext)
    drawPetal(in: CGRect(x: 128, y: 246, width: 9, height: 14), inDegrees: 350,
              inContext: flowerContext)
    drawPetal(in: CGRect(x: 133, y: 236, width: 11, height: 14), inDegrees: 80,
              inContext: flowerContext)

//    рисуем центр и заполняем его
    let center = CGMutablePath()
    let ellipse = CGRect(x: 126, y: 242, width: 6, height: 6)
    center.addEllipse(in: ellipse, transform: .identity)

    let orangeColor = UIColor(red: 255 / 255.0, green: 174 / 255.0,
                              blue: 49.0 / 255.0, alpha: 1.0)

    flowerContext.addPath(center)
    flowerContext.setStrokeColor(UIColor.black.cgColor)
    flowerContext.strokePath()
    flowerContext.setFillColor(orangeColor.cgColor)
    flowerContext.addPath(center)
    flowerContext.fillPath()
    
     // рисуем стебель

    flowerContext.move(to: CGPoint(x: 135, y: 249))
    context.setStrokeColor(UIColor.black.cgColor)
    flowerContext.addQuadCurve(to: CGPoint(x: 133, y: 270),
                               control: CGPoint(x: 145, y: 250))
    flowerContext.strokePath()
    
    
    // теперь уже рисуем цветы
    context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
    context.translateBy(x: 20, y: 10)
    context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
    context.translateBy(x: -30, y: 5)
    context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
    context.translateBy(x: -20, y: -10)
    context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))

  }

  
}
