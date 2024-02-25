//
//  BasketViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BasketDisplayLogic: AnyObject {
    func display(viewModel: Basket.Something.ViewModel)
}

class BasketViewController: UIViewController, BasketDisplayLogic {
    var interactor: BasketBusinessLogic?
    var router: (NSObjectProtocol & BasketRoutingLogic)?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = Basket.Something.Request()
        interactor?.handle(request: request)
    }

    // MARK: Requests

    func display(viewModel: Basket.Something.ViewModel) {
    
    }
}
