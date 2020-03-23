//
//  PushButton.swift
//  Flo
//
//  Created by Hudihka on 21/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit
@IBDesignable //можно посмотреть на происходящие в сториборде
//еще до запуска

class PushButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var isAddButton: Bool = true
    
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    /*
     У каждого из них UIViewесть графический контекст , и все чертежи для представления отображаются в этом контексте перед передачей на аппаратное обеспечение устройства.
     
     iOS обновляет контекст, вызывая draw(_:)всякий раз, когда необходимо обновить представление. Это происходит, когда:
     
     Представление является новым для экрана.
     Другие виды поверх него перемещены.
     Точка зрения в hiddenизменении свойства.
     Ваше приложение явно вызывает методы setNeedsDisplay()или setNeedsDisplayInRect()в представлении.
     */
    
    override func draw(_ rect: CGRect) { //что тот вроде фии инит
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()   //заливка цветом
        
        
        //горизонтальная прямая
        
        // установить переменные ширины и высоты
        // для горизонтального штриха
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2
        
        //создаем криивую безьье
        let plusPath = UIBezierPath()
        
        //толшина линиич
        plusPath.lineWidth = Constants.plusLineWidth
        
        // без учета размеров дисплея
        
        //        // перемещаем начальную точку пути
        //        // в начало горизонтального штриха
        //        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth,
        //                                  y: halfHeight))
        //
        //        // добавляем точку к пути в конце штриха
        //        plusPath.addLine(to: CGPoint(
        //          x: halfWidth + halfPlusWidth,
        //          y: halfHeight))
        
        //        добавляем Constants.halfPointShift что бы не было проблем с изображением на
        //        разных дизайнах
        
        plusPath.move(to: CGPoint(
            x: halfWidth - halfPlusWidth + Constants.halfPointShift,
            y: halfHeight + Constants.halfPointShift))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth + halfPlusWidth + Constants.halfPointShift,
            y: halfHeight + Constants.halfPointShift))
        
        
        //вертикальная прямая
        
        if isAddButton {
        
        plusPath.move(to: CGPoint(
            x: halfWidth + Constants.halfPointShift,
            y: halfHeight - halfPlusWidth + Constants.halfPointShift))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth + Constants.halfPointShift,
            y: halfHeight + halfPlusWidth + Constants.halfPointShift))
        
        }
        
        //устанавливаем цвет обводки
        UIColor.white.setStroke()
        plusPath.stroke()
        
    }
    
    
    
    
}


