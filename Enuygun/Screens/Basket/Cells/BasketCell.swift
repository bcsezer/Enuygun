//
//  BasketCell.swift
//  Enuygun
//
//  Created by cem sezeroglu on 26.02.2024.
//

import UIKit

protocol BasketCellDelegate: AnyObject {
    func didPressRemove(id: Int, index: Int)
    func didPressIncrease(id: Int, index: Int)
    func didPressDecrease(id: Int, index: Int)
}

class BasketCell: UITableViewCell {
    static let identifier = "BasketCell"
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productTitle: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var substractButton: UIButton!
    
    weak var delegate: BasketCellDelegate?
    
    var index: Int?
    private var id: Int?
    private var count: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        apperence()
    }

    func willDisplay(product: Basket.BasketModel) {
        self.id = product.id
        productImage.setImage(imgUrl: product.image)
        productTitle.text = product.name
        productPrice.text = "\(product.price) ₺"
        countLabel.text = product.count.string()
        substractButton.isHidden = !(product.count > 1)
    }
    
    private func apperence() {
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = 10
    }
    
    @IBAction func tapIncrease(_ sender: UIButton) {
        guard let id = id, let index = index else { return }
        delegate?.didPressIncrease(id: id, index: index)
    }
    
    @IBAction func tapDecrase(_ sender: UIButton) {
        guard let id = id, let index = index else { return }
        delegate?.didPressDecrease(id: id, index: index)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        guard let id = id, let index = index else { return }
        delegate?.didPressRemove(id: id, index: index)
    }
}
