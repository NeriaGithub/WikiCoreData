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

    @IBAction func tapSearchButton(_ sender: UIButton) {
        self.searchTexField.resignFirstResponder()
        if !(self.searchTexField.text!.isEmpty) {
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



