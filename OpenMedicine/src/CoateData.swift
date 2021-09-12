//
//  CoateData.swift
//  CoateData
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import SwiftUI

struct CoateData: Codable {
    var data: CoateItem?
}

class CoateItem: Codable, Identifiable {
    var id: Int {
        return cd
    }
    let cd: Int
    let nm: String
    let code: String
    let capital_name: String?
    let capital_code: String?
    let child: [CoateItem]?
    
    var selected: Bool?
    var level: Int?
    
    init(cd: Int, nm: String, code: String, capital_name: String?, capital_code: String?, child: [CoateItem]?, selected: Bool?, level: Int?) {
        self.cd = cd
        self.nm = nm
        self.code = code
        self.capital_name = capital_name
        self.capital_code = capital_code
        self.child = child
        self.selected = selected
        self.level = level
    }
}
