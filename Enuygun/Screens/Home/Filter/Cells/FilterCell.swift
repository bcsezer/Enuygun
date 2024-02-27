//
//  FilterCell.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//

import UIKit

class FilterCell: UITableViewCell {
    static let identifier = "FilterCell"
    
    @IBOutlet private weak var nameLabel: UILabel!
 
    func willDisplay(name: String) {
        self.nameLabel.text = name
    }
}
