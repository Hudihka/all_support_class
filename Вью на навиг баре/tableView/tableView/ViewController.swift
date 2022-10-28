//
//  ViewController.swift
//  tableView
//
//  Created by Hudihka on 31/05/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: SupportViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Human] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Имена"

        getData()
        tableView.delegate = self
        tableView.dataSource = self


//        if #available(iOS 11.0, *) {    //теперь таблица скролится под навиг бар, здесь это не нужно
//            self.tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false
//        }


//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) //навигейшен бар полностью прозрачный
//        navigationController?.navigationBar.shadowImage = UIImage()                                  //навигейшен бар не имеет тени

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customView(true)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let human = dataArray[indexPath.row]
        cell.textLabel?.text = human.name
        cell.backgroundColor = human.gender ? UIColor.red : UIColor.green

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TwoViewController") as? TwoViewController{
            VC.human = dataArray[indexPath.row]
            self.navigationController?.pushViewController(VC, animated: true)
        }


    }


    ///////////

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.animationNavigBar(scrollView: scrollView)
    }


}

extension UIViewController {
    func customView(_ add: Bool) {

        let navBar = self.navigationController?.navigationBar
        titlePosition(isNormal: !add)

        if add {
            let view = CustomView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.size.width, height: 40))
            view.tag = 777
            navBar?.addSubview(view)
        } else {

            guard let subview = navBar?.subviews.filter({$0.tag == 777}).first else {
                return
            }
            subview.removeFromSuperview()
        }
    }

    private func titlePosition(isNormal: Bool){
        let koef: CGFloat = isNormal ? 0 : -40
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(koef, for: UIBarMetrics.default)
    }
}
