//
//  DrugListViewModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 11/11/21.
//

import Foundation

// MARK: - DrugListModel
struct DrugListModel: Codable {
    var items: [DrugItem]
    let count: Int
}

// MARK: - Item
struct DrugItem: Identifiable, Codable {
    var id : String {
        return barcode
    }
    let atc: Atc?
    let barcode: String
    let expiryDate: String?
    let fullName: String?
    let maker, status: Maker?
    let issueDate: String?
    let pricePerUnit: Double?
    let medicineFormula: String?
    let thumbName: String?

    enum CodingKeys: String, CodingKey {
        case atc, barcode
        case expiryDate = "expiry_date"
        case fullName = "full_name"
        case maker, status
        case issueDate = "issue_date"
        case pricePerUnit = "price_per_unit"
        case medicineFormula = "medicine_formula"
        case thumbName = "thumb_name"
    }
}

// MARK: - Atc
struct Atc: Codable {
    let cd: Int
    let nm: String
    let nmEng: String?
}

// MARK: - Maker
struct Maker: Codable {
    let cd: Int
    let nm: String
}
