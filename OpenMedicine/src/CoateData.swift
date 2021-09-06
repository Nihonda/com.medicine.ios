//
//  CoateData.swift
//  CoateData
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import SwiftUI

struct CoateData: Codable {
    var data: CoateItem
}

struct CoateItem: Codable {
    let cd: Int
    let nm: String
    let code: String
    let capital_name: String?
    let capital_code: String?
    let child: [CoateItem]?
}
