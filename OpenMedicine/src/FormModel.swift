//
//  FormModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 15/12/21.
//

import Foundation

// MARK: - FormModel
struct FormModel: Codable {
    let id: Int
    let seq: String
    let full_name: String
    let short_name: String
    let description: String
}
