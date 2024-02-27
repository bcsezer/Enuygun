//
//  FilterInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FilterBusinessLogic {
    func handle(request: Filter.GetData.Request)
    func handle(request: Filter.TapCell.Request)
}

class FilterInteractor: FilterBusinessLogic {
    var presenter: FilterPresentationLogic?
    var product: [Product]?
    
    // MARK: Business Logic

    func handle(request: Filter.GetData.Request) {
        guard let product = product else { return }
        var stringArray: [String] = []
        
        for item in product {
            stringArray.append((request.type == .brand ? item.brand : item.category) ?? "")
        }
        presenter?.present(response: Filter.GetData.Response(type: request.type, data: stringArray))
    }
    
    func handle(request: Filter.TapCell.Request) {
        presenter?.present(response: Filter.TapCell.Response(name: request.name, type: request.type))
    }
}
