//
//  FilterInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FilterBusinessLogic {
    func handle(request: Filter.Something.Request)
}

class FilterInteractor: FilterBusinessLogic {
    var presenter: FilterPresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Filter.Something.Request) {
        let response = Filter.Something.Response()
        presenter?.present(response: response)
    }
}
