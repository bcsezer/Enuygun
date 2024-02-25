//
//  ProductCell.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    static let identifier = "ProductCell"
    
    @IBOutlet private weak var productPreviousPrice: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productDesc: UILabel!
    @IBOutlet private weak var productTitle: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func willDisplay(product: Product) {
        self.productDesc.text = product.description
        self.productPrice.text = product.price?.description
        self.productTitle.text = product.title
        self.productImage.setImage(imgUrl: product.thumbnail ?? "")
    }
}
