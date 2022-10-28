//
//  ViewController.swift
//  CenteredCollectionView-Sample
//
//  Created by Dejan Skledar on 17/04/2018.
//  Copyright © 2018 Dejan Skledar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!

    private var titles = [
        "cersei",
        "daenerys the stormborn",
        "lannister",
        "snow the bastard",
        "stark",
        "baratheon",
        "tyrion the dworf",
        "ГАйфутдинов", "trolololoololool"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewCenterLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = layout
    }
    @IBAction func addTaped(_ sender: Any) {
        let count = titles.count
        let index = arc4random_uniform(UInt32(count - 1))
        let word = titles[Int(index)]
        titles.append(word)
        
        collectionView.performBatchUpdates({
            let index = IndexPath(row: count, section: 0)
            collectionView.insertItems(at: [index])
        }, completion: nil)
        
    }
    
    // MARK - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell",
                                                            for: indexPath) as? RoundedCollectionViewCell else {
                                                                return RoundedCollectionViewCell()
        }
        cell.textLabel.text = titles[indexPath.row]
        return cell
    }
}

