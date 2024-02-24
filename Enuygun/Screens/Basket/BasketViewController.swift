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

    // TODO: Move this function to ViewControllerFactory
    
    func makeBasket() -> UIViewController {
        let viewController = BasketViewController(nibName: "BasketView", bundle: nil)
        let interactor = BasketInteractor()
        let presenter = BasketPresenter()
        let router = BasketRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }

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
