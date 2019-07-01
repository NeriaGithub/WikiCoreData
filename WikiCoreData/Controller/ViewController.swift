//
//  ViewController.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 28.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet weak var searchTexField: UITextField!
    @IBOutlet weak var geoNamesTable: UITableView!
    var geoNameArray:[GeoName] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initVC()
        
    }
    
    
    
    func initVC() {
        self.geoNamesTable.rowHeight = UITableView.automaticDimension
        self.geoNamesTable.estimatedRowHeight = 20
        self.geoNamesTable.tableFooterView = UIView()
        let nib = UINib.init(nibName: "GeoNameCell", bundle: nil)
        self.geoNamesTable.register(nib, forCellReuseIdentifier: "GeoNameCell")
        self.searchTexField.clearButtonMode = .whileEditing
    }
    
    
    
//    func reloadDataTable(keyword:String) {
//        CoreDataManger.getCoreDataManger().getData(keyword: keyword) { (data) in
//            if data != nil{
//                // reload data table
//                self.geoNameArray = data!
//                self.geoNamesTable.reloadData()
//            }
//            else{
//                DispatchQueue.global(qos: .background).async {
//                    ServerManger.getServerManger().getSearchJson(keyword: keyword, completion: { (data) in
//                        if let geoNames = data{
//                            DispatchQueue.main.async {
//                                if !geoNames.isEmpty {
//                                    self.geoNameArray = geoNames
//                                    self.geoNamesTable.reloadData()
//                                    let city:City = City(keyword:keyword , geoNames: geoNames)
//                                    CoreDataManger.getCoreDataManger().saveData(city: city)
//                                }
//                                else{
//                                    Alert.presentAlert(title: "City is not found", VC: self)
//                                }
//                            }
//                        }
//                        else{
//                            // print alert error
//                            //print("faild")
//                            Alert.presentAlert(title: "City is not found", VC: self)
//                        }
//                    })
//                }
//            }
//        }
//    }
    
    
    @IBAction func tapSearchButton(_ sender: UIButton) {
        self.searchTexField.resignFirstResponder()
        if !(self.searchTexField.text!.isEmpty) {
//            reloadDataTable(keyword: self.searchTexField.text!.lowercased())
            DataManager.getDataManager().getData(keyword: self.searchTexField.text!.lowercased()) { (data) in
                if let geoNames = data {
                    self.geoNameArray = geoNames
                    
                }
                else{
                    self.geoNameArray.removeAll()
                    Alert.presentAlert(title: "City is not found", VC: self)
                }
                self.geoNamesTable.reloadData()
            }
        }
        else{
            self.geoNameArray.removeAll()
            self.geoNamesTable.reloadData()
        }
        
    }
    
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.geoNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeoNameCell") as! GeoNameCell
        cell.setGeoNameCell(geoName: self.geoNameArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



