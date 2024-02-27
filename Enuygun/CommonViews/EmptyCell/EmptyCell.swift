//
//  EmptyCell.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import UIKit

class EmptyCell: UITableViewCell {
    static let identifier = "EmptyCell"
    
    @IBOutlet private weak var titleLabel: UILabel!

    func willDisplay(text: String) {
        self.titleLabel.text = text
    }
}
