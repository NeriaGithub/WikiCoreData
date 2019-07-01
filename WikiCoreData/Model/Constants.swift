//
//  Constants.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 28.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation

struct Constants {
    static func getUrlString(keyword:String)->String{
         var stringUrl = "http://api.geonames.org/wikipediaSearchJSON?q=\(keyword)&maxRows=10&username=tingz"
        stringUrl = stringUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return stringUrl
    }
    
    enum coreDataString:String {
        case entity = "Cities"
        case keyWord = "keyword"
        case geoNames = "geoNames"
    }
    
    static let noIcon:String = "noIcon"
    
}
