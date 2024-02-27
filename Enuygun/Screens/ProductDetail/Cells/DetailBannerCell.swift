//
//  DetailBannerCell.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import UIKit
import Kingfisher

class DetailBannerCell: UICollectionViewCell {
   static let identifier = "DetailBannerCell"
    
    @IBOutlet private weak var bannerImage: UIImageView!
    
    func willdisplay(image: String) {
        bannerImage.setImage(imgUrl: image)
    }
}
