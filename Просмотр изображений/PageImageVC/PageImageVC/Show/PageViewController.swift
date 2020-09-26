//
//  PageViewController.swift
//  PageImageVC
//
//  Created by Hudihka on 25/09/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
	
	
	var startIndex = 0
	var endIndex = 0 //количество экранов - 1
	
	var imageArray: [UIImage] = []
    fileprivate lazy var VCArr: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.content()
        self.customNavigationBar()
        self.bacground()
        self.baseSettings()
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        for view in self.view.subviews {
//            if let viewPage = view as? UIPageControl {
//                viewPage.pageIndicatorTintColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
//                viewPage.currentPageIndicatorTintColor = SupportClass.Colors.orangeLogo
//            }
//        }
//    }

    private func customNavigationBar() {

        let button = UIBarButtonItem(title: "Продолжить", style: .plain, target: self, action: #selector(exit))
        navigationItem.rightBarButtonItem = button
    }

    @objc private func exit() {
		self.navigationController?.dismiss(animated: true, completion: nil)
    }

    private func bacground() {
		
		self.view.backgroundColor = .clear
//        let imageBack = UIImage(named: "backgr1") ?? UIImage()
//
//        imageViewBacgr = UIImageView(image: imageBack)
//        imageViewBacgr?.contentMode = .scaleAspectFill
//        view.insertSubview(imageViewBacgr!, at: 0)
    }

    private func content() {
        var returnArray: [UIViewController] = []
        for i in 0...5 {
            let VC = createVC(i)
            returnArray.append(VC)
        }
        VCArr = returnArray
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func baseSettings() {
        self.delegate = self
        self.dataSource = self

        if let firstVC = VCArr.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return VCArr.last
        }

        guard VCArr.count > previousIndex else {
            return nil
        }

        return VCArr[previousIndex]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < VCArr.count else {
            return VCArr.first
        }

        guard VCArr.count > nextIndex else {
            return nil
        }

        return VCArr[nextIndex]
    }

    fileprivate func createVC(_ index: Int) -> UIViewController {
        guard let VC = Storyboard.page.getStoryboard().instantiateViewController(withIdentifier: "ViewControllerPageInfo") as? ViewControllerPageInfo else {
            return UIViewController()
        }

        VC.settingsVC(index: index)
        return VC
    }

    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArr.count
    }

    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = VCArr.index(of: firstViewController) else {
                return 0
        }

        return firstViewControllerIndex
    }
}

