//
//  Array+Extensions.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//

import Foundation

extension Array {
    var removingDuplicates: [Element] {
        NSOrderedSet(array: self).array.compactMap({ $0 as? Element })
    }
}
