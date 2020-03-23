//
//  OneViewController.swift
//  counnteinnerVC
//
//  Created by Hudihka on 12/12/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {
    @IBOutlet weak var oneLabel: UILabel!

    var structHuman: Human?

    override func viewDidLoad() {
        super.viewDidLoad()

        oneLabel.text = structHuman?.name ?? "no_contens"
    }

    static func route(structHuman: Human) -> OneViewController{
        let stor = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = stor.instantiateViewController(withIdentifier: "OneViewController") as! OneViewController

        vc.structHuman = structHuman
//        vc.loadViewIfNeeded()

        return vc
    }

    @IBAction func butto(_ sender: Any) {

        print("--------")
    }

}

class TwoViewController: UIViewController {
    @IBOutlet weak var oneLabel: UILabel!

    var structHuman: Human?

    override func viewDidLoad() {
        super.viewDidLoad()

        oneLabel.text = structHuman?.lastName ?? "no_contens"
    }

    static func route(structHuman: Human) -> TwoViewController{
        let stor = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = stor.instantiateViewController(withIdentifier: "TwoViewController")  as! TwoViewController

        vc.structHuman = structHuman
//        vc.loadViewIfNeeded()

        return vc
    }


}

class FrieViewController: UIViewController {
    @IBOutlet weak var oneLabel: UILabel!

    var structHuman: Human?

    override func viewDidLoad() {
        super.viewDidLoad()

        oneLabel.text = structHuman?.fullNName ?? "no_contens"
    }

    static func route(structHuman: Human) -> FrieViewController{
        let stor = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = stor.instantiateViewController(withIdentifier: "FrieViewController") as! FrieViewController

        vc.structHuman = structHuman
//        vc.loadViewIfNeeded()

        return vc
    }


}


struct Human {
    let name = "fffff"
    let lastName = "aaaa"
    let fullNName = "nnnnnnn"
}
