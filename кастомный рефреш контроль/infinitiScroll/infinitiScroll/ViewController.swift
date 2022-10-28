//
//  ViewController.swift
//  infinitiScroll
//
//  Created by Username on 30.12.2019.
//  Copyright © 2019 itMegastar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //добавить надо под тейбл вью
    //и должна быть тем же размером что и ТВ
    @IBOutlet weak var refreshView: RefreshView!
    

    var dataArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addData(30)
		
		
        desingTV()
		createRefreshView()
    }
	
	private func createRefreshView(){
		
		refreshView?.block = {
			// убираем анимац нижнюю вью
		}
        
        
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -1 * heightView, right: 0)
	}
	

    fileprivate func loadContent() {
		if refreshView?.animateCirkles ?? true {
			return
		}
        
        print("//загрузка контента")
		
		//загрузка контента
    }
    


    func addData(_ count: Int){

        var newData: [String] = []
        for _ in 0...count - 1 {
            newData.append("_")
        }

        dataArray = dataArray + newData
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{

    func desingTV(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = .clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "индекс \(indexPath.row + 1)"
		
		cell.contentView.backgroundColor = .red

        return cell
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		//убираем рефреш вью
		refreshView?.stopedAnimateRotate()
	}
	
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let scrollWey = scrollView.contentOffset.y + scrollView.frame.height
        let height = scrollView.contentSize.height
        
        if scrollWey > height {
            print(scrollWey - height)
        }
	}
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
           /*
         юзер отпустил палец
         */
        
        loadContent()
    }
}

