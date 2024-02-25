//
//  EndpointType.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
