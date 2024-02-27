//
//  FavoritesCell.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import UIKit
import Kingfisher

protocol FavoritesDelegate: AnyObject {
    func didTapAdd(selectedProduct: Product)
}

class FavoritesCell: UICollectionViewCell {
    static let identifier = "FavoritesCell"
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var addButton: UIButton!
    
    weak var delegate: FavoritesDelegate?
    private var selectedProduct: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        apperance()
    }

    func willDisplay(product: Product) {
        self.selectedProduct = product
        titleLabel.text = product.title
        descLabel.text = product.description
        productImage.setImage(imgUrl: product.thumbnail ?? "")
        priceLabel.text = product.price?.string() ?? "" + "₺"
    }
    
    private func apperance() {
        addButton.layer.cornerRadius = addButton.frame.size.width/2
        addButton.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    @IBAction func tapAdd(_ sender: Any) {
        guard let product = selectedProduct else { return }
        delegate?.didTapAdd(selectedProduct: product)
    }
}
