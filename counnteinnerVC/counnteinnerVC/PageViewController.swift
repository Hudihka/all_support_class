//
//  PageViewController.swift
//  counnteinnerVC
//
//  Created by Hudihka on 12/12/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    lazy var VCArr: [UIViewController] = []
    var nextIndex = 0

    var tupl: TulpSettingsPageVC? {
        didSet{
            self.baseSettings()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    static func route() -> PageViewController{
        let stor = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = stor.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController

        return vc
    }


    func content(_ human: Human) {
        VCArr = [OneViewController.route(structHuman: human),
                 TwoViewController.route(structHuman: human),
                 FrieViewController.route(structHuman: human)]
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func baseSettings() {

        guard let tupl = tupl else {
            return
        }

        content(tupl.model)

        let newInndex = tupl.index

        if newInndex > VCArr.count - 1{
            return
        }

        gestureActiveVC(true)

        let animate: NavigationDirection = newInndex > nextIndex ? .forward : .reverse

        let vc = VCArr[newInndex]
        setViewControllers([vc], direction: animate, animated: true, completion: nil)

    }

    func gestureActiveVC(_ active: Bool){
        if active {
            self.delegate = self;
            self.dataSource = self;
        } else {
            self.delegate = nil;
            self.dataSource = nil;
        }
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            gestureActiveVC(false)
            return VCArr.last
        }

        guard VCArr.count > previousIndex else {
            return nil
        }

        gestureActiveVC(false)

        return VCArr[previousIndex]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }

        nextIndex = viewControllerIndex + 1

        guard nextIndex < VCArr.count else {
            gestureActiveVC(false)
            nextIndex = 0
            return VCArr.first
        }

        guard VCArr.count > nextIndex else {

            return nil
        }
        gestureActiveVC(false)


        return VCArr[nextIndex]
    }



//    func pageViewController(_: UIPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool){
//
//        if didFinishAnimating{
//            gestureActiveVC(false)
//        }
//
//    }



//    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return VCArr.count
//    }
//
//    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let firstViewController = viewControllers?.first,
//            let firstViewControllerIndex = VCArr.index(of: firstViewController) else {
//                return 0
//        }
//
//        return firstViewControllerIndex
//    }

}
