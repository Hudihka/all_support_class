//
//  TestVC.swift
//  infinitiScroll
//
//  Created by Hudihka on 01/05/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class TestVC: UIViewController {
	
	/*
	
	ДИСПАТЧИ ЗАДЕРЖКИ НА менее чем на 0.3 сек спользую для того
	что бы статус бар успел стать прозрачным  наоборот
	
	*/
	
	private var flagAnimate = false
	
	private var isHideStatusBar = false
	private var isFlip = false
	
	private var statusBarScreen: UIImageView?
	private var labelInfo: UILabel?
	
	private var contentView: UIView?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
    }
	
	override var prefersStatusBarHidden: Bool {
		 return isHideStatusBar
	}
	
	var statusBarView: UIView?{
		return UIApplication.shared.statusBarView
	}
	
	private func initContentView(){
		if let statusBarView = statusBarView {
			self.contentView = UIView(frame: statusBarView.frame)
			self.contentView?.backgroundColor = .clear
			self.view.addSubview(contentView!)
		}
	}
	
	private func initScreenSBAndLabel(label: UILabel){
		if let statusBarView = statusBarView, let contentView = contentView{
			
			let frameSB = CGRect(origin: .zero, size: statusBarView.frame.size)
			
			label.frame = frameSB
			self.labelInfo = label
			
			contentView.addSubview(labelInfo!)
			
			statusBarScreen = UIImageView(frame: frameSB)
			//ставь цвет бэкграунда супервью
			//в данном случае вью контроллера
			statusBarScreen?.backgroundColor = .white
			statusBarScreen?.image = statusBarView.screenshot
			
			contentView.addSubview(statusBarScreen!)
			
			
		}
	}
	
	var testLabel: UILabel{ //здесь используем вью для теста
		let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
		label.text = "TEXT"
		label.textColor = .white
		label.backgroundColor = .red
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		
		return label
	}

	
	@IBAction func tapedAction(_ sender: UIButton) {
		
		if flagAnimate {//нужно для того что бы не началось 2 анимации подрят
			return
		}
		
		flagAnimate = true
		
		initContentView() //создаем вью на статус баре
		//делаем скриншот статус бара, присваиваем лейбл с информацией
		//можно сделать любой фрейм
		initScreenSBAndLabel(label: self.testLabel)
		
//		делаем статус бар прозрачным
		isHideStatusBar = true
		setNeedsStatusBarAppearanceUpdate()
		
		//первая анимация
		flipAnimate(comBlock: nil)
//
//
		weak var selF = self
		flipAnimate {
			//делаем статус бар не прозрачным
			selF?.isHideStatusBar = false
			selF?.setNeedsStatusBarAppearanceUpdate()
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
				selF?.contentView = nil
				selF?.labelInfo = nil
				selF?.statusBarScreen = nil
				selF?.flagAnimate = false
			}
		}
		
		
		
		
		//		isHideStatusBar = !isHideStatusBar
		//		setNeedsStatusBarAppearanceUpdate()
		
//		if let view = UIApplication.shared.statusBarView {
//
//			let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 100),
//													  size: view.frame.size))
//
//			let imageSB = view.screenshot
//			imageView.image = imageSB
//
//			self.view.addSubview(imageView)
//		}
	}
	
	
	private func flipAnimate(comBlock: (() -> Void)?){
		
		guard let labelInfo = labelInfo, let statusBarScreen = statusBarScreen else {
			return
		}
		
		isFlip = !isFlip
		
		let startView = isFlip ? statusBarScreen : labelInfo
		let finishView = isFlip ? labelInfo : statusBarScreen
		let option: UIView.AnimationOptions = isFlip ? .transitionFlipFromTop : .transitionFlipFromBottom
		
		//перв
		let time: DispatchTime = comBlock == nil ? .now() + 0.2 : .now() + 2
		
		DispatchQueue.main.asyncAfter(deadline: time) {
			UIView.transition(from: startView,
							  to: finishView,
							  duration: 0.5,
							  options: [.curveEaseOut, option]) { (compl) in
								if compl {
									comBlock?()
								}
			}
		}
		
		
	}
	
	
}
