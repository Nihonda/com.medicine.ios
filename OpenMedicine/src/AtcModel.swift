//
//  AtcModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 15/12/21.
//

import Foundation

// MARK: - AtcModel
struct AtcModel: Codable {
    let id: Int
    let atc_code: String
    let atc_name_eng: String
    let atc_name_rus: String
}
