//
//  DetailViewController.swift
//  MathMonsters
//
//  Created by Админ on 18.01.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weaponImageView: UIImageView!

    var monster: Monster? {
      didSet {
        refreshUI()
      }
    }


    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    private func refreshUI() {
      loadViewIfNeeded()
      nameLabel.text = monster?.name
      descriptionLabel.text = monster?.description
      iconImageView.image = monster?.icon
      weaponImageView.image = monster?.weapon.image
    }

}
