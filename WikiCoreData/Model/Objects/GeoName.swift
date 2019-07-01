//
//  GeoName.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 28.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation
class GeoName:NSObject,Decodable,NSCoding{
    
    var  summary:String?;
    var  title:String?;
    var thumbnailImg:String?
    
    required  init(coder aDecoder: NSCoder) {
        self.summary = (aDecoder.decodeObject(forKey: "summary") as? String);
        self.title = (aDecoder.decodeObject(forKey: "title") as? String)
        self.thumbnailImg = (aDecoder.decodeObject(forKey: "thumbnailImg") as? String)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(summary, forKey: "summary");
        aCoder.encode(title, forKey: "title")
        aCoder.encode(thumbnailImg, forKey: "thumbnailImg")
        
    }
    
}
