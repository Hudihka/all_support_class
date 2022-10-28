//
//  CollectionHeader.swift
//  doubleParalax
//
//  Created by Hudihka on 19/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

//import UIKit
//
//class CollectionHeader: UICollectionView {
//
//    var dataArray: [UIImage]? {
//        didSet{
//            guard let array = dataArray else {return}
//            refrehData(array)
//        }
//    }
//
//    private func refrehData(_ images: [UIImage]){
//        self.isScrollEnabled = images.count > 1
//        self.reloadData()
//    }
//
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        super.init(frame: frame, collectionViewLayout: layout)
//
//
//
//        backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
//        delegate = self
//        dataSource = self
//        register(CellCollection.self, forCellWithReuseIdentifier: "Cell")
//
//        layout.minimumLineSpacing = 0
//
//        showsHorizontalScrollIndicator = false
//        showsVerticalScrollIndicator = false
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//
//
//}
//
//
//extension CollectionHeader: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataArray?.count ?? 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellCollection
//
//        cell.newImage = dataArray?[indexPath.row]
//
//        return cell
//    }
//
//}
