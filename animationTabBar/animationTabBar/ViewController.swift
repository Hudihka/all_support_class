//
//  ViewController.swift
//  animationTabBar
//
//  Created by Hudihka on 05/10/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonPresent(_ sender: UIButton) {

        //высотта таб бара на обычном айфоне 49.0
                                  //на 10тке 83.0

//        self.present(TwoViewController.route(), animated: true, completion: nil)

//        MyTabBar.getTabBar().setTabBarVisible(visible: false, animated: true)
//        setTabBarVisible(visible: !tabBarIsVisible(), animated: true, completion: {_ in })
    }


    // pass a param to describe the state change, an animated flag and a completion block matching UIView animations completion
    func setTabBarVisible(visible: Bool, animated: Bool, completion:@escaping (Bool)->Void) {

        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) {
            return completion(true)
        }

        // get a frame calculation ready
        let height = tabBarController!.tabBar.frame.size.height
        let offsetY = (visible ? -height : height)

        // zero duration means no animation
        let duration = (animated ? 0.3 : 0.0)

        UIView.animate(withDuration: duration, animations: {
            let frame = self.tabBarController!.tabBar.frame
            self.tabBarController!.tabBar.frame = CGRect(x: 0, y: offsetY, width: frame.width, height: frame.height)
        }, completion:completion)
    }

    func tabBarIsVisible() -> Bool {
        return tabBarController!.tabBar.frame.origin.y < view.frame.origin.y
    }
    
}

