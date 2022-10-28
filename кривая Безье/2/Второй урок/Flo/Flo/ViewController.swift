//
//  ViewController.swift
//  Flo
//
//  Created by Hudihka on 21/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Counter outlets
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!

    //отоьражается ли сейчас график
    var isGraphViewShowing = true

    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counterView.counter)
    }
    
    @IBAction func pushButtonPressed(_ button: PushButton) {
      if button.isAddButton {
        counterView.counter += 1
      } else {
        if counterView.counter > 0 {
          counterView.counter -= 1
        }
      }
      counterLabel.text = String(counterView.counter)
    }

    
     
    @IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?) {
      if (isGraphViewShowing) {
        //hide Graph
        
//        выполняет горизонтальный флип-переход
        UIView.transition(from: graphView,
                          to: counterView,
                          duration: 1.0,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          completion:nil)
      } else {
        //show Graph
        UIView.transition(from: counterView,
                          to: graphView,
                          duration: 1.0,
                          options: [.transitionFlipFromRight, .showHideTransitionViews],
                          completion: nil)
      }
        
      isGraphViewShowing = !isGraphViewShowing
        
         
//        if isGraphViewShowing {
//          counterViewTap ( nil )
//        }

    }



}

