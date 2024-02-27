//
//  FilterPresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FilterPresentationLogic {
    func present(response: Filter.Something.Response)
}

class FilterPresenter: FilterPresentationLogic {
    weak var viewController: FilterDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Filter.Something.Response) {
        let viewModel = Filter.Something.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
}
