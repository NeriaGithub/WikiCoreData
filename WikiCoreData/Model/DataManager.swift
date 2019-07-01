//
//  DataManager.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 30.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation

class DataManager {
    private static var sharedInstance:DataManager?;
    private init(){
    }
    public  static func getDataManager()->DataManager
    {
        if DataManager.sharedInstance == nil{
            DataManager.sharedInstance = DataManager();
        }
        return DataManager.sharedInstance!
    }
    
    func getData(keyword:String, completion:@escaping([GeoName]?)->()) {
        CoreDataManger.getCoreDataManger().getData(keyword: keyword) { (data) in
            if  data != nil{
                completion(data)
            }
            else{
                DispatchQueue.global(qos: .background).async {
                    ServerManger.getServerManger().getSearchJson(keyword: keyword, completion: { (jsonData) in
                        if let geoNames = jsonData{
                            DispatchQueue.main.async {
                                if !geoNames.isEmpty{
                                    let city:City = City(keyword:keyword , geoNames: geoNames)
                                    CoreDataManger.getCoreDataManger().saveData(city: city)
                                    completion(geoNames)
                                }
                                else{
                                    completion(nil)
                                }
                            }
                        }
                        else{
                            completion(nil)
                        }
                    })
                    
                }
            }
        }
    }
    
}
