//
//  CountryModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 15/12/21.
//

import Foundation

// MARK: - CountryModel
struct CountryModel: Codable {
    let id: Int
    let country_code: String
    let country_name: String
    let country_fullname: String
    let country_prefix: String
    let country_prefix2: String
}
