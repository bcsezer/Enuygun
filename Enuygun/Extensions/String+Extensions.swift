//
//  String+Extensions.swift
//  Enuygun
//
//  Created by cem sezeroglu on 26.02.2024.
//

import Foundation

extension String {
    func stringToFloat() -> CGFloat? {
        guard let doubleValue = Double(self) else {
            return nil
        }
        return CGFloat(doubleValue)
    }
}
