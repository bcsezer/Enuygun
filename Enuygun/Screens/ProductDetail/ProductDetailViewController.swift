//
//  ProductDetailViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailDisplayLogic: AnyObject {
    func display(viewModel: ProductDetail.Something.ViewModel)
}

class ProductDetailViewController: UIViewController, ProductDetailDisplayLogic {
    var interactor: ProductDetailBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailRoutingLogic)?

    // TODO: Move this function to ViewControllerFactory
    
    func makeProductDetail() -> UIViewController {
        let viewController = ProductDetailViewController(nibName: "ProductDetailView", bundle: nil)
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
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
        let request = ProductDetail.Something.Request()
        interactor?.handle(request: request)
    }

    // MARK: Requests

    func display(viewModel: ProductDetail.Something.ViewModel) {
    
    }
}
