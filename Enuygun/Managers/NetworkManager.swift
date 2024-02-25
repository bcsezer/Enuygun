//
//  NetworkManager.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    
    let provider = NetworkProvider<RemoteEndpoint>()
    
    func getList(completion: @escaping ClosureType<ProductEntity>, failure: @escaping Failure) {
        provider.request(
            .getAllProducts,
            model: ProductEntity.self,
            completion: completion,
            failure: failure
        )
    }
    
    func getSearched(text: String, completion: @escaping ClosureType<ProductEntity>, failure: @escaping Failure) {
        provider.request(
            .getSearchedProduct(searchText: text),
            model: ProductEntity.self,
            completion: completion,
            failure: failure
        )
    }
}
