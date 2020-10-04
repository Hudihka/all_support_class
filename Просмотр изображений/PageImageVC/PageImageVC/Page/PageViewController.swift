//
//  PageViewController.swift
//  PageImageVC
//
//  Created by Hudihka on 25/09/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit


class PageViewController: UIViewController {
	
	fileprivate var startIndex: IndexPath = IndexPath(row: 0, section: 0)
	fileprivate var dataArray = DataManager.imageNameArray
	
	@IBOutlet fileprivate weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .black
		
		self.customNavigationBar()
		self.settingsCV()
		self.settingsTitle(startIndex)
		
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.collectionView.scrollToItem(at: startIndex,
										 at: [.centeredVertically, .centeredHorizontally],
										 animated: false)
	}
	
	
	/*функция применяется для безанмационного (как в телеграме/медиатеке) показа изображений*/
	
	static func presentPageVC(_ fromVC: UIViewController, startIndex: IndexPath){
		
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
		
//		navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 0.5, blue: 1, alpha: 1)
//		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//		navigationController?.navigationBar.shadowImage = UIImage()
//		navigationController?.navigationBar.isTranslucent = true
		
		navigationController?.setNavigationBarHidden(false, animated: false)
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		 navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = true
		 navigationController?.view.backgroundColor = UIColor(red: 1, green: 0.5, blue: 1, alpha: 1)
		 navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 0.5, blue: 1, alpha: 1)
		
		
		let button = UIBarButtonItem(title: "Продолжить", style: .plain, target: self, action: #selector(exit))
		let colorBB = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
		button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : colorBB], for: .normal)
		navigationItem.rightBarButtonItem = button
	}
	
	@objc private func exit() {
		self.navigationController?.dismiss(animated: true, completion: nil)
	}
	
	private func settingsTitle(_ index: IndexPath){
		self.title = "\(index.row + 1) из \(dataArray.count)"
	}
	
	private func clerarNavigationBar() {
		
		guard let NB = self.navigationController else {return}
		
		let isOriginalFrame = rectNavigationBar(true) == NB.navigationBar.frame
		
		let finalFrame = rectNavigationBar(!isOriginalFrame)
		
		UIApplication.shared.keyWindow?.windowLevel = isOriginalFrame ? .statusBar : .normal
		
		UIView.animate(withDuration: timeInterval) {
			NB.navigationBar.frame = finalFrame
		}
		
	}
	
	fileprivate func colorNB(_ alpha: CGFloat){
		
		guard let navigationController = navigationController else {return}
		
		let colorNB = UIColor(red: 1, green: 0.5, blue: 1, alpha: alpha)
		navigationController.navigationBar.tintColor = colorNB
		
		let colorFont = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
		let attributes = [NSAttributedString.Key.foregroundColor : colorFont] as [NSAttributedString.Key : Any]
		navigationController.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
	
	}
	
}


extension PageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	
	fileprivate func settingsCV() {
		self.collectionView.backgroundColor = .clear
		
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		
		self.collectionView.decelerationRate = .fast
		self.collectionView.contentInsetAdjustmentBehavior = .never
		
		self.collectionView.register(UINib(nibName: "ZoomCell", bundle: nil),
									 forCellWithReuseIdentifier: "ZoomCell")
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataArray.count
	}
	

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZoomCell", for: indexPath) as! ZoomCell
		
		cell.image = dataArray[indexPath.row]
		
		cell.clerarNavigationBar = {
			self.clerarNavigationBar()
		}
		
		cell.translationBlock = {[weak self] alpha in
			print(alpha)
//			self?.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
			self?.colorNB(alpha)
		}

		cell.closeBlock = { [weak self] value in
			self?.navigationController?.dismiss(animated: true, completion: nil)
		}

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
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView,
								   withVelocity velocity: CGPoint,
								   targetContentOffset: UnsafeMutablePointer<CGPoint>) {

		targetContentOffset.pointee = scrollView.contentOffset
		var indexes = self.collectionView.indexPathsForVisibleItems
		indexes.sort()
		var index = indexes.first!
		let cell = self.collectionView.cellForItem(at: index)!
		let position = self.collectionView.contentOffset.x - cell.frame.origin.x
		if position > cell.frame.size.width/2{
		   index.row = index.row+1
		}
		self.settingsTitle(index)
		self.collectionView.scrollToItem(at: index, at: .left, animated: true )
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
