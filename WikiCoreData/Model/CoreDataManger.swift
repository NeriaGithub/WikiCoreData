//
//  CoreDataManger.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 28.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation
import CoreData
import UIKit
public class CoreDataManger{
    private static var sharedInstance:CoreDataManger?;
    
    //let context = appDelegate.persistentContainer.viewContext
   private let context:NSManagedObjectContext?
    
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as!AppDelegate;
        self.context = appDelegate.persistentContainer.viewContext
        
    }
    
    public  static func getCoreDataManger()->CoreDataManger
    {
        if CoreDataManger.sharedInstance == nil{
            CoreDataManger.sharedInstance = CoreDataManger();
        }
        return CoreDataManger.sharedInstance!
    }
    
    func saveData(city:City)  {
        let entity = NSEntityDescription.entity(forEntityName: Constants.coreDataString.entity.rawValue, in: context!)
        let cityObj:NSManagedObject = NSManagedObject(entity: entity!, insertInto: self.context)
        cityObj.setValue(city.keyword, forKey: Constants.coreDataString.keyWord.rawValue)
        cityObj.setValue(city.geoNames, forKey: Constants.coreDataString.geoNames.rawValue)
        do {
            try self.context!.save()
        }
        catch  {
            //print("failed save")
           
        }
    }
    
    func getData(keyword:String,completion:([GeoName]?)->())  {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataString.entity.rawValue)
         request.predicate = NSPredicate(format: "\(Constants.coreDataString.keyWord.rawValue) = %@", keyword.lowercased())
        request.fetchLimit = 1
        
        do {
            let result = try self.context!.fetch(request)
            if result.count > 0{
                if let data = result.first as? Cities{
                    if let geoNames = data.geoNames as? [GeoName]{
                        completion(geoNames)
                    }
                    else{completion(nil)}
                }
                else{completion(nil)}
            }
            else{completion(nil)}
        }
        catch  {completion(nil)}
    }
    
}


