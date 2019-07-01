//
//  GeoNameCell.swift
//  WikiCoreData
//
//  Created by Neria Jerafi on 28.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import UIKit

class GeoNameCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summrayLabel: UILabel!
    
    @IBOutlet weak var thumbnailsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setGeoNameCell(geoName:GeoName) {
      self.titleLabel.text = geoName.title ?? ""
        self.summrayLabel.text = geoName.summary ?? ""
        getImage(url: geoName.thumbnailImg)
        
    }

   
    func getImage(url:String?) {
        if url != nil{
            DispatchQueue.global(qos: .background).async {
                if let imageUrl = URL(string: url!){
                    do{
                        let imageData = try Data(contentsOf: imageUrl);
                        DispatchQueue.main.async {
                            self.thumbnailsImageView.image = UIImage(data: imageData, scale: 1.0);
                            if self.thumbnailsImageView.image == nil{
                                self.thumbnailsImageView?.image = UIImage(named: Constants.noIcon)
                            }
                        }
                    }
                    catch{}
                }
            }
        }
        else{
            self.thumbnailsImageView?.image = UIImage(named: Constants.noIcon)
        }
    }
}
