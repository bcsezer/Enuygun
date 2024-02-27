//
//  FilterPresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FilterPresentationLogic {
    func present(response: Filter.GetData.Response)
    func present(response: Filter.TapCell.Response)
}

class FilterPresenter: FilterPresentationLogic {
    weak var viewController: FilterDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Filter.GetData.Response) {
        var cells: [Filter.Rows] = []
  
        for item in response.data.removingDuplicates {
            cells.append(.filter(title: item, type: response.type))
        }
        
        viewController?.display(viewModel: Filter.GetData.ViewModel(rows: cells))
    }
    
    func present(response: Filter.TapCell.Response) {
        viewController?.display(viewModel: Filter.TapCell.ViewModel(name: response.name, type: response.type))
    }
}
