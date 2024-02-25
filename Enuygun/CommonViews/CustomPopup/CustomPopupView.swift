//
//  CustomPopupView.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import UIKit

class CustomPopupView: UIViewController {
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    
    var onDissmissed: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    init() {
        super.init(nibName: "CustomPopupView", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
        self.doneButton.layer.cornerRadius = 10
    }
    
    func present(sender: UIViewController, type: PopupType) {
        sender.present(self, animated: false) {
            DispatchQueue.main.async {
                self.show()
                self.titleLabel.text = type.title()
                self.descLabel.text = type.text()
                self.iconImage.image = type.image()
            }
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.onDissmissed?()
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}

