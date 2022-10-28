//
//  ViewController.swift
//  CodableCoreData
//
//  Created by Константин Ирошников on 17.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goRequest(_ sender: Any) {
//        let req = TestUsersReguest()
//        req.completion = { [weak self] users, error in
//            self?.labelTitle.text = users?.last?.title
//
//			print(users)
//			print(users?.count)
//        }
//		let req = TestUsersCDRequest()
//		req.completion = { [weak self] error in
//			if error == nil {
//				let users = CoreDataUtilities<User>.getAllObject()
//				self?.labelTitle.text = users.last?.title
//				print(users.count)
//			}
//		}

    }

}

