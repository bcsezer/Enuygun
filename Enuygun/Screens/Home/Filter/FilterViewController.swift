//
//  FilterViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FilterDisplayLogic: AnyObject {
    func display(viewModel: Filter.Something.ViewModel)
}

class FilterViewController: UIViewController, FilterDisplayLogic {
    var interactor: FilterBusinessLogic?
    var router: (NSObjectProtocol & FilterRoutingLogic)?

    // TODO: Move this function to ViewControllerFactory
    
    func makeFilter() -> UIViewController {
        let viewController = FilterViewController(nibName: "FilterView", bundle: nil)
        let interactor = FilterInteractor()
        let presenter = FilterPresenter()
        let router = FilterRouter()
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
        let request = Filter.Something.Request()
        interactor?.handle(request: request)
    }

    // MARK: Requests

    func display(viewModel: Filter.Something.ViewModel) {
    
    }
}
