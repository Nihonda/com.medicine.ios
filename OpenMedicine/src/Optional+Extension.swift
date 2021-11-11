//
//  Optional+Extension.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 12/11/21.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}
