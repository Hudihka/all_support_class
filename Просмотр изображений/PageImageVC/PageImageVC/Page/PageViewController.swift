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
	var countVC = 0 //количество экранов
	
	var imageArray: [UIImage] = []
    fileprivate lazy var VCArr: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        VCArr = Array(1...countVC).map { _ in ViewControllerPageInfo.route() }
		
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
	
	/*функция применяется для безанмационного (как в телеграме/медиатеке) показа изображений*/
	
	static func presentPageVC(_ fromVC: UIViewController, startIndex: Int, countVC: Int){
		
		if startIndex > countVC {
			return
		}
		
		let storuboard = UIStoryboard(name: "PageStoryboard", bundle: nil)
	
		let VC = storuboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
		VC.startIndex = startIndex
		VC.countVC = countVC
		
		let NVC = UINavigationController(rootViewController: VC)
		NVC.modalPresentationStyle = .fullScreen
		
		fromVC.present(NVC, animated: true, completion: nil)

	}
	

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
		guard let viewControllerIndex = VCArr.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard VCArr.count > previousIndex else {
            return nil
        }
		
		if let VC = VCArr[previousIndex] as? ViewControllerPageInfo {
			VC.image = imageFrom(previousIndex)
			return VC
		}

        return nil
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = VCArr.firstIndex(of: viewController) else {
            return nil
        }
		
		let nextIndex = viewControllerIndex + 1

        guard nextIndex < VCArr.count else {
            return nil
        }

        guard VCArr.count > nextIndex else {
            return nil
        }
		
		if let VC = VCArr[nextIndex] as? ViewControllerPageInfo {
			VC.image = imageFrom(nextIndex)
			return VC
		}
		
		return nil
    }
	

	private func imageFrom(_ index: Int) -> UIImage{
		return UIImage(named: "img_\(index)") ?? UIImage()
	}
	


}

