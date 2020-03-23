//
//  CounterView.swift
//  Flo
//
//  Created by Hudihka on 21/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

import UIKit

@IBDesignable class CounterView: UIView {
  
  private struct Constants {
    static let numberOfGlasses = 8 //целевое количество стаканов, выпиваемых в день
    static let lineWidth: CGFloat = 5.0
    static let arcWidth: CGFloat = 76
    
    static var halfOfLineWidth: CGFloat {
      return lineWidth / 2
    }
  }
  
  @IBInspectable var counter: Int = 5 {
    didSet {
      if counter <=  Constants.numberOfGlasses {
        setNeedsDisplay()
      }
    }
  }

  @IBInspectable var outlineColor: UIColor = UIColor.blue
  @IBInspectable var counterColor: UIColor = UIColor.orange
  
  override func draw(_ rect: CGRect) {
    // 1
    let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    let radius: CGFloat = max(bounds.width, bounds.height) / 2

    // 3
    let startAngle: CGFloat = 3 * .pi / 4
    let endAngle: CGFloat = .pi / 4

    // 4
    let path = UIBezierPath(arcCenter: center,
                               radius: radius - Constants.arcWidth/2,
                           startAngle: startAngle,
                             endAngle: endAngle,
                            clockwise: true) //по часовой стрелке

    // 5
    path.lineWidth = Constants.arcWidth
    counterColor.setStroke()
    path.stroke()
    
    
    
    // Нарисовать контур

    // 1 - сначала вычислить разницу между двумя углами
    //, убедившись, что она положительная,
    let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
     // затем вычислить дугу для каждого отдельного стекла,
    let arcLengthPerGlass = angleDifference / CGFloat ( Constants.numberOfGlasses)
     // затем умножить на количество выпитых стаканов.
    let outlineEndAngle = arcLengthPerGlass * CGFloat (counter) + startAngle

    // 2 - нарисовать внешнюю дугу
    let outlinePath = UIBezierPath (arcCenter: center,
                                      radius: bounds.width / 2 - Constants.halfOfLineWidth,
                                  startAngle: startAngle,
                                    endAngle: outlineEndAngle,
                                   clockwise: true )

    // 3 - нарисовать внутреннюю дугу
    outlinePath.addArc(withCenter: center,
                           radius: bounds.width / 2 - Constants.arcWidth + Constants.halfOfLineWidth,
                       startAngle: outlineEndAngle,
                         endAngle: startAngle,
                        clockwise: false )
        
    // 4 - закрыть путь
    outlinePath.close ()
        
    outlineColor.setStroke ()
    outlinePath.lineWidth = Constants.lineWidth
    outlinePath.stroke ()
    
    
    
    
    //MARK: Поворот контекста
    //РИСУЕМ СПИДОМЕТР
    
    let context = UIGraphicsGetCurrentContext()!
      
    //1 - сохраняем контекст
    context.saveGState()
    outlineColor.setFill()
        
    let markerWidth: CGFloat = 5.0
    let markerSize: CGFloat = 10.0

    //прямоугольник маркера, расположенный в верхнем левом углу
    let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2, y: 0, width: markerWidth, height: markerSize))

    //3 - переместить верхний левый угол контекста в предыдущую центральную позицию
    context.translateBy(x: rect.width / 2, y: rect.height / 2)
        
    for i in 1...Constants.numberOfGlasses {
      //4 - сохранить центрированный контекст
      context.saveGState()
      //5 - высчитываем угол поворота
      let angle = arcLengthPerGlass * CGFloat(i) + startAngle - .pi / 2
      //повернуть и перевести
      context.rotate(by: angle)
      context.translateBy(x: 0, y: rect.height / 2 - markerSize)
       
      //6 - заполнить прямоугольник маркера
      markerPath.fill()
      //7 - восстановить центрированный контекст для следующего поворота
      context.restoreGState()
    }

    //8 - восстановить исходное состояние в случае дополнительной отрисовки
    context.restoreGState()


  }
}

