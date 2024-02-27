//
//  SortViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SortDisplayLogic: AnyObject {
    func display(viewModel: Sort.Something.ViewModel)
}

class SortViewController: UIViewController, SortDisplayLogic {
    var interactor: SortBusinessLogic?
    var router: (NSObjectProtocol & SortRoutingLogic)?

    // TODO: Move this function to ViewControllerFactory
    
    func makeSort() -> UIViewController {
        let viewController = SortViewController(nibName: "SortView", bundle: nil)
        let interactor = SortInteractor()
        let presenter = SortPresenter()
        let router = SortRouter()
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
        let request = Sort.Something.Request()
        interactor?.handle(request: request)
    }

    // MARK: Requests

    func display(viewModel: Sort.Something.ViewModel) {
    
    }
}
