//
//  CityGeoNames.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 28.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation
class CityGeoNames:NSObject, Decodable, NSCoding {
    
     var  geonames:[GeoName]?
    
    
    
    
    
    
    required  init(coder aDecoder: NSCoder) {
        self.geonames = (aDecoder.decodeObject(forKey: "geonames") as? [GeoName])
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(geonames, forKey: "geonames");
        
    }
    
}
