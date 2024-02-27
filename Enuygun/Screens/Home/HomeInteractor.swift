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
    func handle(request: Home.TapSort.Request)
    func handle(request: Home.SelectFilter.Request)
    func handle(request: Home.TapFilter.Request)
    func handle(request: Home.Search.Request)
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    let manager = NetworkManager.shared
    private var product: ProductEntity?
    // MARK: Business Logic

    func handle(request: Home.GetInitial.Request) {
        manager.getList { result in
            self.product = result
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: result.total ?? 0, product: result.products ?? []))
        } failure: { error in
            print(error)
        }
    }
    
    func handle(request: Home.Search.Request) {
        self.product = nil
        let searchText = request.text.replacingOccurrences(of: " ", with: "")
        manager.getSearched(text: searchText) { result in
            self.product = result
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: result.total ?? 0, product: result.products ?? []))
        } failure: { error in
            print(error)
        }
    }
    
    func handle(request: Home.TapFilter.Request) {
        presenter?.present(response: Home.TapFilter.Response(product: self.product?.products ?? []))
    }
    
    func handle(request: Home.TapSort.Request) {
        switch request.sortType {
        case .alphabetical:
            let sorted = self.product?.products?.sorted { $0.title?.lowercased() ?? "" < $1.title?.lowercased() ?? "" } ?? []
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: self.product?.total ?? 0, product: sorted))
        case .decrease:
            let decrease = self.product?.products?.sorted { $0.price ?? 0 > $1.price ?? 0 } ?? []
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: self.product?.total ?? 0, product: decrease))
        case .increase:
            let increase = self.product?.products?.sorted { $0.price ?? 0 < $1.price ?? 0 } ?? []
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: self.product?.total ?? 0, product: increase))
        case .clean:
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: self.product?.total ?? 0, product: self.product?.products ?? []))
        }
    }
    
    func handle(request: Home.SelectFilter.Request) {
        switch request.filterType {
        case .category:
            let category = self.product?.products?.filter({ $0.category == request.name}) ?? []
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: self.product?.total ?? 0, product: category))
        case .brand:
            let brand = self.product?.products?.filter({ $0.brand == request.name }) ?? []
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: self.product?.total ?? 0, product: brand))
        case .clean:
            self.presenter?.present(response: Home.GetInitial.Response(totalCount: self.product?.total ?? 0, product: self.product?.products ?? []))
        }
    }
}
