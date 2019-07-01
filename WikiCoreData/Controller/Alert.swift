//
//  Alert.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 29.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    static func presentAlert(title:String,VC:UIViewController){
        let alert:UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .default, handler: nil))
        VC.present(alert, animated: false, completion: nil);
        
    }
}
