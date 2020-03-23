//
//  ViewController.swift
//  testCollectionView
//
//  Created by Hudihka on 06/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray = [String]()
    
    
    private enum PresentationStyle: String, CaseIterable {
        case table
        case defaultGrid
        case customGrid
        
        var buttonImage: UIImage {
            switch self {
            case .table: return  UIImage(named: "list") ?? UIImage()
            case .defaultGrid: return  UIImage(named: "settings") ?? UIImage()
            case .customGrid: return  UIImage(named: "user") ?? UIImage()
            }
        }
    }
    
    private var selectedStyle: PresentationStyle = .table {
        didSet {
            updatePresentationStyle()
        }
    }
    
    private var styleDelegates: [PresentationStyle: CollectionViewSelectableItemDelegate] = {
        let result: [PresentationStyle: CollectionViewSelectableItemDelegate] = [
            .table: TabledContentCollectionViewDelegate(),
            .defaultGrid: DefaultGriddedContentCollectionViewDelegate(),
            .customGrid: CustomGriddedContentCollectionViewDelegate(),
        ]
        
        result.values.forEach {
            $0.didSelectItem = { _ in
                print("Item selected")
            }
        }
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        settingsCV()
        
        updatePresentationStyle()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedStyle.buttonImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(changeContentLayout))
    }
    
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItem?.image = selectedStyle.buttonImage
        
        collectionView.delegate = styleDelegates[selectedStyle]
        collectionView.performBatchUpdates({
            collectionView.reloadData()
        }, completion: nil)
    }
    
    @objc private func changeContentLayout() {
        //меняем кнопки на навигейшен баре
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: selectedStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        selectedStyle = allCases[nextIndex]
    }
    
    
    // MARK: - DATA
    
    private func getData(){
        for _ in 0...55{
            dataArray.append(objImg())
        }
    }
    
    private func objImg() -> String{
        let number = arc4random_uniform(94)
        return "img_\(number)"
    }
    

}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension ViewController: UICollectionViewDataSource {

    // MARK: - CollectionView

    func settingsCV() {
//        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.contentInset = .zero

        self.collectionView.register(UINib(nibName: "MyCustomCell", bundle: nil),
                                     forCellWithReuseIdentifier: "MyCustomCell")

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCell


        cell.name = dataArray[indexPath.row]

        return cell
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        didSelectItemAt indexPath: IndexPath) {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = wDdevice/3
//        return CGSize(width: size, height: size)
//    }
    

}

protocol CollectionViewSelectableItemDelegate: class, UICollectionViewDelegateFlowLayout {
    var didSelectItem: ((_ indexPath: IndexPath) -> Void)? { get set }
}


class DefaultCollectionViewDelegate: NSObject, CollectionViewSelectableItemDelegate {
    
    var didSelectItem: ((_ indexPath: IndexPath) -> Void)?
    let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 20.0, right: 16.0)
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }

}


//MARK: - ТАБЛИЧНАЯ

class TabledContentCollectionViewDelegate: DefaultCollectionViewDelegate {
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left + sectionInsets.right
        let widthPerItem = collectionView.bounds.width - paddingSpace
        //мы берем отступы по сторонам и отнимаем
        //это от ширины коллекции
        return CGSize(width: widthPerItem, height: 112)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        //расстояние между строками и столбцами
        return 10
    }
}

//MARK: - 3 ячейки в ряд
class DefaultGriddedContentCollectionViewDelegate: DefaultCollectionViewDelegate {
    private let itemsPerRow: CGFloat = 3 //сколько ячеек в ряду
    private let minimumItemSpacing: CGFloat = 8 //расстояние между ячейками
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow //размер ячейки
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
}

//MARK: - КОМБИНИРОВАННАЯ

class CustomGriddedContentCollectionViewDelegate: DefaultCollectionViewDelegate {
    private let itemsPerRow: CGFloat = 3
    private let minimumItemSpacing: CGFloat = 8
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize: CGSize
        
        if indexPath.item % 4 == 0 {
            let itemWidth = collectionView.bounds.width - (sectionInsets.left + sectionInsets.right)
            itemSize = CGSize(width: itemWidth, height: 112)
        } else {
            let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
            let availableWidth = collectionView.bounds.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            itemSize = CGSize(width: widthPerItem, height: widthPerItem)
        }
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
}
