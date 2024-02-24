//
//  HomePresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func present(response: Home.Something.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Home.Something.Response) {
        let viewModel = Home.Something.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
}
