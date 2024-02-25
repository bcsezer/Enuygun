//
//  RemoteEndpoint.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//

import Foundation

enum RemoteEndpoint {
    case getAllProducts
    case getSearchedProduct(searchText: String)
}

extension RemoteEndpoint: EndpointType {
    var baseURL: URL {
        switch self {
        case .getAllProducts:
            guard let url = URL(string: URLs.baseUrl) else { fatalError("baseURL could not be configured.")}
            return url
        case .getSearchedProduct:
            guard let url = URL(string: URLs.searchUrl) else { fatalError("detailURL could not be configured.")}
            return url
        }
    }
    
    var path: String {
        switch self {
        case .getAllProducts:
            return ""
        case .getSearchedProduct(let text):
            return text
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllProducts:
            return .get
        case .getSearchedProduct:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAllProducts:
            return .requestParameters(
                bodyEncoding: .urlEncoding,
                urlParameters: .none
            )
        case .getSearchedProduct:
            return .requestParameters(
                bodyEncoding: .urlEncoding,
                urlParameters: .none
            )
        }
    }
}
