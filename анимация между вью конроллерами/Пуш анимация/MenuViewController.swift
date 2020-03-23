//
//  MenuViewController.swift
//  GinzaGO
//
//  Created by Username on 30.01.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit

typealias TuplPresentFoodAnimation = (CGRect, UIImage, MenuStruct, CellFoodCollectionView)

class MenuViewController: SupportViewController, UITableViewDelegate, UITableViewDataSource {
    var testColor: UIColor?
    @IBOutlet weak var sliderButton: MMSlidingButton!

    @IBOutlet weak var hederView: CompoundHeders!

    @IBOutlet weak var downTableViewCondtrait: NSLayoutConstraint!
    @IBOutlet weak var viewFooter: UIView!

    let howToGet = ""//"Как пройти"
    let getMenu = "Посмотреть меню"

    let shelvesNumber = "Полка №%ld"

    var model: FridgeFull!

    var arrayList: [MenuStruct] = []
    var arrayShelves: [[MenuStruct]] = []

    var sliderIsList = true
    var counterSection = 0
    var numberRow = 0

    var selctedTupl: TuplPresentFoodAnimation?

    static var activeMenuVC = false

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.desing()
        self.sliderButton.delegate = self

        self.arrayList = model.getAllFoodSorted()
        self.arrayShelves = model.getOneArrayPlanogram()

        self.desingTableView()

        MenuViewController.activeMenuVC = true

        self.navigationController?.delegate = self

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadBlureVC(notfication:)),
                                               name: .reloadBlureVC,
                                               object: nil)
    }
    // MARK: - SCROLL
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hederView.customParalax(scrollView)
        self.animationNavigBar(scrollView: scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.stoppedScrolling(scrollView: scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.stoppedScrolling(scrollView: scrollView)
        }
    }

    func returnHTabl() -> Bool {
        let defaultHTable = self.tableView.frame.height
        var hTable: CGFloat = 0
        if sliderIsList {
            hTable = CGFloat(145 * arrayList.count)
        } else {
            hTable = CGFloat(arrayShelves.count * (145 + 36))
        }

        return hTable > defaultHTable
    }

    static func route(fridgeFull: FridgeFull) -> MenuViewController? {
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
        let controller = viewController as? MenuViewController

        controller?.model = fridgeFull

        return controller
    }

    // MARK: - desing

    func desing() {
        self.addshadow(view: self.sliderButton,
                       viewW: Double(SupportClass.Dimensions.wDdevice - 32),
                       viewH: 46)

        self.hederView.fridge = self.model
        self.hederView.delegate = self

        //navigationItem.rightBarButtonItems = [self.getBBItem(.settingsFoodTag), self.getBBItem(.support)]
        navigationItem.rightBarButtonItems = [self.getBBItem(.support)]
    }

    func desingTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.separatorColor = SupportClass.Colors.clear
        self.tableView.backgroundColor = SupportClass.Colors.clear

        self.tableView.bottomScrollView()

        self.tableView.heigtHedersTableView(addInfo: 68)
        self.tableView.reloadData()
    }

    // MARK: - ACTION

    @objc func reloadBlureVC(notfication: Notification) { //перезагрузка меню при покупке
        GGApi.getOneFridge { (fridge, _) in
            if let fridge = fridge, fridge.isActive {
                self.arrayList = fridge.getAllFoodSorted()
                self.arrayShelves = fridge.getOneArrayPlanogram()
                self.tableView.reloadData()
            } else {
                return
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        MenuViewController.activeMenuVC = false
    }

    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return sliderIsList ? 1 : arrayShelves.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sliderIsList ? arrayList.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.selectionStyle = .none

        self.counterSection = indexPath.section
        self.numberRow = indexPath.row

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? MenuTableViewCell else {
            return
        }

        tableViewCell.setCollectionViewDataSourceDelegate(tableViewCell, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = 0
        tableViewCell.delegate = self

        if sliderIsList {
            tableViewCell.arrayTuple = [arrayList[indexPath.row]]
        } else {
            tableViewCell.arrayTuple = arrayShelves[indexPath.section]
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SupportClass.isIPhone5 ? 180 : 145
    }

    // MARK: - HEDERS

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sliderIsList {
            return nil
        }

        let view = UILabel(frame: CGRect(x: 0,
                                         y: 0,
                                         width: Int(SupportClass.Dimensions.wDdevice),
                                         height: 23))

        view.backgroundColor = UIColor.clear

        let label = UILabel(frame: CGRect(x: 16,
                                          y: 5,
                                          width: 250,
                                          height: 18))

        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = .left
        let number = arrayShelves[section].first?.planogram.row ?? 6
        label.text = String(format: shelvesNumber, number)
        label.settingsFont(number: 15)

        view.addSubview(label)

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !sliderIsList {
            return 28
        } else {
            return 0
        }
    }
}

extension MenuViewController: ReloadDataMenuVCTable {
    func reloadTableView(zeroIndex: Bool) {
        self.sliderIsList = zeroIndex

        self.counterSection = 0
        self.tableView.reloadData()
    }
}

extension MenuViewController: SelectedMenuCellProtocol, UINavigationControllerDelegate {
    func selectedMenu(cell: CellFoodCollectionView, rect: CGRect, menu: MenuStruct) {
        let rect = rectImageInTV(menu, rectImage: rect)
        let tulp = (rect, cell.getActiveImage, menu, cell)
        self.selctedTupl = tulp

        self.presentAlertAPay(menu)
    }

    private func presentAlertAPay(_ menu: MenuStruct) {
        if let food = menu.food, let VC = FoodViewController.route(food: food) {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }

    //получаем нужную секцию

    private func rectImageInTV(_ menu: MenuStruct, rectImage: CGRect) -> CGRect {
        if sliderIsList, let row = self.arrayList.firstIndex(where: { $0.food == menu.food }) {
            return getORiginY(index: IndexPath(row: row, section: 0), rectImage: rectImage)
        } else {
            let section = menu.planogram.row - 1
            return getORiginY(index: IndexPath(row: 0, section: section), rectImage: rectImage)
        }
    }

    //получаем позицию ячейки табл
    //и от туда получаем рект изображения

    private func getORiginY(index: IndexPath, rectImage: CGRect) -> CGRect {
        let rectOfCellInTableView = tableView.rectForRow(at: index)
        let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)

        let rect = CGRect(x: rectImage.origin.x,
                          y: rectOfCellInSuperview.origin.y + rectImage.origin.y,
                          width: rectImage.width,
                          height: rectImage.height)

        return rect
    }

    // MARK: - АНИМАЦИЯ ПЕРЕХОДА

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push && fromVC is MenuViewController {
            guard let tupls = self.selctedTupl else {
                return nil
            }

            tupls.3.clearImageCell()

            return PresentFoodAnimation(tupl: tupls)
        } else if operation == .pop && toVC is MenuViewController, let tupls = self.selctedTupl {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationTimeIntervalFood - 0.27) { //необходимо что бы избежать противного мигания
                tupls.3.clearImageCell()
            }

            let image = tupls.3.getActiveImage.alpha(1)

            return DismissFoodAnimation(frame: tupls.0, image: image, menu: tupls.2)
        }

        return nil
    }
}
