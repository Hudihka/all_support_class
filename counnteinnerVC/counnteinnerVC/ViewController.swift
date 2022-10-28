//
//  ViewController.swift
//  counnteinnerVC
//
//  Created by Hudihka on 12/12/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

typealias TulpSettingsPageVC = (model: Human, index: Int)

class ViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var segmentOutlet: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func actionSegmennt(_ sender: UISegmentedControl) {

        reloadPageVC(model: Human())


//        if let pageVC = self.children.first as? PageViewController, index + 1 <= pageVC.VCArr.count {
//
//            pageVC.gestureActiveVC(true)
//
//            let vc = pageVC.VCArr[index]
//            pageVC.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
//
//        }

    }

    private func reloadPageVC(model: Human){

        if let pageVC = self.children.first as? PageViewController {
            pageVC.tupl = TulpSettingsPageVC(model: model, index: segmentOutlet.selectedSegmentIndex)
        }

    }


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segue_pageVC",
//            let index = sender as? Int,
//            let pageVC = segue.destination as? PageViewController,
//            index + 1 <= pageVC.VCArr.count {
//
//            pageVC.gestureActiveVC(true)
//
//            let vc = pageVC.VCArr[index]
//            pageVC.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
//
//            pageVC.gestureActiveVC(false)
//
//        }
//    }

}

