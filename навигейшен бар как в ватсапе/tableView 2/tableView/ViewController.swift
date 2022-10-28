//
//  ViewController.swift
//  tableView
//
//  Created by Hudihka on 31/05/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Human] = []

    var  newDataArray:[Human] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Имена"

        getData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))//чистка футера

        setupNavBar()
    }

    func settingsSerchController(){
    }

    func setupNavBar(){  //настройки навиг бара
        navigationController?.navigationBar.prefersLargeTitles = true //большая надпись титульника скрывается

        ///просто добавляем серч бар

        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self   //здесь мы говорим что в этом вк меняем данные
        searchController.obscuresBackgroundDuringPresentation = false //что бы не затемняло фон
        searchController.searchBar.placeholder = "Поиск засранцев" //ну понятно и так
        searchController.searchBar.setValue("назад", forKey: "_cancelButtonText") //текст кнопки назад
        definesPresentationContext = true //как только мы переходим к другомы ВК строка поиска исчезает

        //navigationItem.hidesSearchBarWhenScrolling = false ///теперь серч бар не уходит, уходит только титульник
        ///

        navigationItem.searchController = searchController
        searchController.searchBar.showsScopeBar = true //сегмент контрол теперь видно всегда а не только при поиске
        searchController.searchBar.scopeButtonTitles = ["All", "Пацаны", "Девушки"] //это уже сегмент контроллер
        searchController.searchBar.delegate = self

    }

    func getData(){
        for _ in 0...50{
            let gender = arc4random_uniform(100000000) < 50000000
            let human = Human.init(name: getName(gender: gender), gender: gender)
            self.dataArray.append(human)
        }
    }


    func getName(gender: Bool) -> String {
        let array = gender ? ArrayName.nameMan : ArrayName.nameFemale
        let number = arc4random_uniform(UInt32(array.count - 1))
        return array[Int(number)]
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getArray().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let array = getArray()
        let human = array[indexPath.row]
        cell.textLabel?.text = human.name
        cell.backgroundColor = human.gender ? UIColor.red : UIColor.green

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TwoViewController") as? TwoViewController{
            let array = getArray()
            VC.human = array[indexPath.row]
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }

    //MARK: - UISearchController - поиск

    func updateSearchResults(for searchController: UISearchController) {//метод делегата
        if let text = searchController.searchBar.text {
            if let index = navigationItem.searchController?.searchBar.selectedScopeButtonIndex {
                if index == 0{
                    reloadNewDataArry(text)
                } else {
                    reloadNewDataArry(text, gender: index == 1)
                }
            }
//            reloadNewDataArry(text)
        }

    }

    func isClearSerchBar() -> Bool {    //пустой ли серч бар
        return navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }

    func reloadNewDataArry(_ str: String, gender: Bool? = nil) {// lowercased() делает строку ПРОПИСНЫМИ буквами

        guard let gen = gender else {
            self.newDataArray = self.dataArray.filter({$0.name.lowercased().contains(str.lowercased())})
            self.tableView.reloadData()
            return
        }

        self.newDataArray = self.dataArray.filter({$0.gender == gen})  //фильтрация с учетом пола

        if !str.isEmpty {
            self.newDataArray = self.newDataArray.filter({$0.name.lowercased().contains(str.lowercased())})//фильтрация с учетом пола
        }


        self.tableView.reloadData()
    }


    private func  isFiltering() -> Bool {  //идет ли фильтрация в данный момент
        let activeVallue = navigationItem.searchController?.isActive ?? true
        let searchBarScopeIsFiltering = navigationItem.searchController?.searchBar.selectedScopeButtonIndex != 0
        return activeVallue && (!isClearSerchBar() || searchBarScopeIsFiltering)
    }

    func getArray() -> [Human]{ //возвращает нужный массив взависимости от ситуации
        if isFiltering() {
            return self.newDataArray
        } else {
            return self.dataArray
        }
    }

    //MARK: - UISearchBarDelegate -

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) { // метод делегата, нажатие на сегмент контроль
        let text = searchBar.text ?? ""

        if selectedScope == 0 {
            self.reloadNewDataArry(text)
        } else {
            self.reloadNewDataArry(text, gender: selectedScope == 1)
        }
    }




}

