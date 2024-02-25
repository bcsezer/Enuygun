//
//  ImageView+Extension.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import UIKit
import Kingfisher

extension UIImageView{
    func setImage(imgUrl: String) {
        self.kf.setImage(with: URL(string: imgUrl))
    }
}
