//
//  ServerManager.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 28.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation

public class ServerManger{
    private static var sharedInstance:ServerManger?;
    private init(){
    }
    public  static func getServerManger()->ServerManger
    {
        if ServerManger.sharedInstance == nil{
            ServerManger.sharedInstance = ServerManger();
        }
        return ServerManger.sharedInstance!
    }
    
    func getSearchJson(keyword:String,completion:@escaping([GeoName]?)->()) {
        guard let url = URL(string: Constants.getUrlString(keyword: keyword)) else { return  }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data{
                do{
                   let geoNamesData = try JSONDecoder().decode(CityGeoNames.self, from: jsonData)
                    completion(geoNamesData.geonames)
                }
                catch{completion(nil)}
            }
            else{completion(nil)}
        }.resume()
        
    }
    
    
    
}
