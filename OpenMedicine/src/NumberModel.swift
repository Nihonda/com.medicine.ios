//
//  NumberModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 7/11/21.
//

import Foundation

struct NumberModel: Codable {
    let numOf: NumberCount
}

struct NumberCount: Codable {
    let count: Int
}
