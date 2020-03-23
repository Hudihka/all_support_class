//
//  ViewController.swift
//  tableView
//
//  Created by Hudihka on 31/05/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var dataArray:[RandomText] = []

//    internal var selectedIndexPath: IndexPath? { если один индекс
    internal var selectedIndexPath: [IndexPath]? {
        didSet{
            //(own internal logic removed)

            //these magical lines tell the tableview something's up, and it checks cell heights and animates changes
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")

//        tableView.estimatedRowHeight = 76
//        tableView.rowHeight = UITableView.automaticDimension

        tableView.reloadData()
    }

    func getData(){
        for _ in 0...50{
            let struc = RandomText(tittle: "\(arc4random_uniform(500))", subTittle: self.randomString())
            dataArray.append(struc)
        }
    }


    private func randomString() -> String {
        let letters: NSString = "abcdefABCDEF123456789"
        let len = 5 + arc4random_uniform(70)

        let randomString: NSMutableString = NSMutableString(capacity: Int(len))

        for _ in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }

        return randomString as String
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = .none
        cell.textStruct = dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if var arrayInd = self.selectedIndexPath, arrayInd.contains(indexPath){
            if arrayInd.count == 1 {
                self.selectedIndexPath = nil
            } else {
                arrayInd = arrayInd.filter({$0 != indexPath})
                self.selectedIndexPath = arrayInd
            }
        } else {
            if self.selectedIndexPath == nil {
                self.selectedIndexPath = [indexPath]
            } else {
                self.selectedIndexPath?.append(indexPath)
            }
        }


        //если один индекс
//
//        if indexPath == self.selectedIndexPath {
//            self.selectedIndexPath = nil
//        }else{
//            self.selectedIndexPath = indexPath
//        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath == self.selectedIndexPath { если только один
        if let arrayInd = self.selectedIndexPath, arrayInd.contains(indexPath) {
            return UITableView.automaticDimension
        }else{
            return CGFloat(220)
        }
    }




}

struct RandomText {
    var tittle: String
    var subTittle: String
}

