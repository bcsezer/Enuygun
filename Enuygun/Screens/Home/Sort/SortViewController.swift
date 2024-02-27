//
//  SortViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SortType {
    case decrease
    case increase
    case alphabetical
    case clean
}

protocol ProductsSortDelegate: AnyObject {
    func didPressSort(type: SortType)
}

class SortViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    weak var delegate: ProductsSortDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       apperances()
    }
    
    private func apperances() {
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }
    
    @IBAction func tapDecrease(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.didPressSort(type: .decrease)
        })
    }
    
    @IBAction func tapIncrease(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.didPressSort(type: .increase)
        })
    }
    
    @IBAction func tapAlphabetical(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.didPressSort(type: .alphabetical)
        })
    }
    
    @IBAction func tapClean(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.didPressSort(type: .clean)
        })
    }
    
    @IBAction func tapClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
