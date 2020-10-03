//
//  PageViewController.swift
//  PageImageVC
//
//  Created by Hudihka on 25/09/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit


class PageViewController: UIViewController {
	
	fileprivate var startIndex = 0
	fileprivate var dataArray = DataManager.imageNameArray
	
	@IBOutlet fileprivate weak var collectionView: UICollectionView!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .black
		
		self.customNavigationBar()
		self.settingsCV()
	}
	
	
	/*функция применяется для безанмационного (как в телеграме/медиатеке) показа изображений*/
	
	static func presentPageVC(_ fromVC: UIViewController, startIndex: Int){
		
		let storuboard = UIStoryboard(name: "PageStoryboard", bundle: nil)
		
		let VC = storuboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
		
		
		VC.startIndex = startIndex
		
		let NVC = UINavigationController(rootViewController: VC)
		
		NVC.providesPresentationContextTransitionStyle = true
		NVC.definesPresentationContext = true
		NVC.modalPresentationStyle = .overCurrentContext
		
		fromVC.present(NVC, animated: true, completion: nil)
		
	}
	
	private func customNavigationBar() {
		
		let button = UIBarButtonItem(title: "Продолжить", style: .plain, target: self, action: #selector(exit))
		navigationItem.rightBarButtonItem = button
	}
	
	@objc private func exit() {
		self.navigationController?.dismiss(animated: true, completion: nil)
	}
	
}


extension PageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	
	fileprivate func settingsCV() {
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		
		
		self.collectionView.register(UINib(nibName: "ZoomCell", bundle: nil),
									 forCellWithReuseIdentifier: "ZoomCell")
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataArray.count
	}
	

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZoomCell", for: indexPath) as! ZoomCell
		
		cell.image = dataArray[indexPath.row]


        return cell
    }


    func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: wDdevice, height: hDdevice)
    }
	
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
	
}


/*

class PageViewController: UIPageViewController {

	fileprivate var startIndex = 0
	fileprivate var countVC = 0 //количество экранов
	
    fileprivate lazy var VCArr: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        VCArr = Array(1...countVC).map { _ in ViewControllerPageInfo.route() }
		self.view.backgroundColor = .black
		
        self.customNavigationBar()
        self.baseSettings()
    }

	
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
		
		NVC.providesPresentationContextTransitionStyle = true
		NVC.definesPresentationContext = true
		NVC.modalPresentationStyle = .overCurrentContext
		
		fromVC.present(NVC, animated: true, completion: nil)
		
	}
	

    private func customNavigationBar() {

        let button = UIBarButtonItem(title: "Продолжить", style: .plain, target: self, action: #selector(exit))
        navigationItem.rightBarButtonItem = button
    }

    @objc private func exit() {
		self.navigationController?.dismiss(animated: true, completion: nil)
    }


}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	func baseSettings() {
		self.delegate = self
		self.dataSource = self
		
		if let firstVC = VCArr[startIndex] as? ViewControllerPageInfo {
			firstVC.image = imageFrom(startIndex)
			settingsTitle(startIndex)
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
		
		return VCFrom(previousIndex)
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
		
		return VCFrom(nextIndex)
	}
	
	private func VCFrom(_ index: Int) -> UIViewController?{
		if let VC = VCArr[index] as? ViewControllerPageInfo {
			VC.image = imageFrom(index)
			VC.translationBlock = { value in
				print(value)
				self.view.backgroundColor = UIColor.black.withAlphaComponent(value)
			}
			
			VC.closeBlock = { isClose in
				if isClose {
					//анимаця закрытия
				} else {
					UIView.animate(withDuration: timeInterval) {
						self.view.backgroundColor = UIColor.black
					}
				}
				
			}
			
			return VC
		}
		
		return nil
	}
	
	
	private func imageFrom(_ index: Int) -> UIImage{
		return UIImage(named: "img_\(index)") ?? UIImage()
	}
	
	private func settingsTitle(_ index: Int){
		self.title = "\(index + 1) из \(countVC)"
	}
	
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if completed {
            guard let newIndex = VCArr.firstIndex(where: { $0 == pageViewController.viewControllers?.last }) else { return }
			settingsTitle(newIndex)
        }

    }
	
	
}

*/
