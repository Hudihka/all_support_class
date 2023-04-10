//
//  ViewController.swift
//  testHole
//
//  Created by Худышка К on 10.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let skeletonView = UIView()
    private let topSkeletonView = UIView()
    private let topHoll = UIView()
    
    static func generateVC() -> UIViewController {
        let stor = UIStoryboard(name: "Main", bundle: nil)
        let VC = stor.instantiateViewController(withIdentifier: "ViewController")
        
        return VC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(skeletonView)
        skeletonView.backgroundColor = .red
        skeletonView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        
        
        
        addHoll()
    }

    
    func addHoll() {
        topSkeletonView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        topSkeletonView.backgroundColor = .green

        // Create the initial layer from the view bounds.
        let maskLayer = CAShapeLayer()
        maskLayer.frame = topSkeletonView.bounds
        maskLayer.fillColor = UIColor.black.cgColor

        let rect = CGRect(x: 10, y: 10, width: 70, height: 20)

        // Create the path.
        let path = UIBezierPath(rect: topSkeletonView.bounds)
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        // Append the circle to the path so that it is subtracted.
        path.append(UIBezierPath(rect: rect))
        maskLayer.path = path.cgPath

        // Set the mask of the view.
        topSkeletonView.layer.mask = maskLayer

        // Add the view so it is visible.
        skeletonView.addSubview(topSkeletonView)
    }
    

}

/*
 let overlay = UIView(frame: CGRectMake(0, 0,
     UIScreen.mainScreen().bounds.width,
     UIScreen.mainScreen().bounds.height))

 // Set a semi-transparent, black background.
 overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)

 // Create the initial layer from the view bounds.
 let maskLayer = CAShapeLayer()
 maskLayer.frame = overlay.bounds
 maskLayer.fillColor = UIColor.blackColor().CGColor

 // Create the frame for the circle.
 let radius: CGFloat = 50.0
 let rect = CGRectMake(
         CGRectGetMidX(overlay.frame) - radius,
         CGRectGetMidY(overlay.frame) - radius,
         2 * radius,
         2 * radius)

 // Create the path.
 let path = UIBezierPath(rect: overlay.bounds)
 maskLayer.fillRule = kCAFillRuleEvenOdd

 // Append the circle to the path so that it is subtracted.
 path.appendPath(UIBezierPath(ovalInRect: rect))
 maskLayer.path = path.CGPath

 // Set the mask of the view.
 overlay.layer.mask = maskLayer

 // Add the view so it is visible.
 self.view.addSubview(overlay)
 */
