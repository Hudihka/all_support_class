//
//  GraphView.swift
//  Flo
//
//  Created by Hudihka on 22/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit


class GraphView: UIView {
    
    private struct Constants {
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 20.0 //отступ
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
    }
    
    var graphPoints = [ 4 , 2 , 6 , 4 , 5 , 8 , 3 ] //точки для графика
    
    // 1
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        //MARK: - рисуем график
        // получения текущего контекста
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // цветовое пространство
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        // 5
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        //отсекаем углы вьюхи(лучши исползовать слои)
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        
        
        //        получить х точку
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            // Рассчитать разрыв между точками
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
        
        
        // вычисляем точку y
        
        let topBorder = Constants .topBorder
        let bottomBorder = Constants .bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = {(graphPoint: Int ) -> CGFloat  in
            let y = CGFloat(graphPoint) / CGFloat (maxValue) * graphHeight
            return graphHeight + topBorder - y // Отразить график
        }
        
        //MARK: - рисуем граффик
 
        UIColor.white.setFill()
        UIColor.white.setStroke()
            
        // устанавливаем линию точек
        let graphPath = UIBezierPath()

        // стартовая точка
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
            
        // рисуем по точком дальше
        for i in 1..<graphPoints.count {
          let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
          graphPath.addLine(to: nextPoint)
        }
        
        //если нужен только граффик то надо это расскоментить
                graphPath.stroke()
        
        //MARK: - градиент под граффиком
        
        //сохранение контекста
        //что бы в дольнейшем рисовать по верх того что есть
        context.saveGState()
            
        //делаю копию линии графика
        let clippingPath = graphPath.copy() as! UIBezierPath
            
        //3 - Заполните область угловыми точками и закройте путь.
        //Это добавляет нижнюю правую и нижнюю левую точки графика.
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y:height))
        clippingPath.addLine(to: CGPoint(x:columnXPoint(0), y:height))
        clippingPath.close()
            
        //4 - Добавьте обтравочный контур в контекст.
        //Когда контекст заполнен, только обрезанный путь фактически заполнен.
        clippingPath.addClip()
            
        //Заполните контекст нужным цветом
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
                
        context.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])

        context.restoreGState()
        //толщина линий
        graphPath.lineWidth = 2.0
        graphPath.stroke ()

        
        // рисуем точки

        for i in 0..<graphPoints.count {
          var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
          point.x -= Constants.circleDiameter / 2
          point.y -= Constants.circleDiameter / 2
              
          let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
          circle.fill()
        }
        
        
        
        //рисуем 3 линии
        
        let linePath = UIBezierPath()

        //top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))

        //center line
        linePath.move(to: CGPoint(x: margin, y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight/2 + topBorder))

        //bottom line
        linePath.move(to: CGPoint(x: margin, y:height - bottomBorder))
        linePath.addLine(to: CGPoint(x:  width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
            
        linePath.lineWidth = 1.0
        linePath.stroke()

    }
}
