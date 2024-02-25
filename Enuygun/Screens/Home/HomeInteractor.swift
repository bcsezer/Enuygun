//
//  HomeInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func handle(request: Home.GetInitial.Request)
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    let manager = NetworkManager.shared
    // MARK: Business Logic

    func handle(request: Home.GetInitial.Request) {
        manager.getList { result in
            self.presenter?.present(response: Home.GetInitial.Response(product: result))
        } failure: { error in
            print(error)
        }
    }
}
