//
//  DrugDetailModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 14/11/21.
//

import Foundation

struct DrugDetailModel: Codable {
    let detail: DetailItem
}

struct DetailItem: Codable {
    let atc: Atc?
    let barcode: String
    let pricePerUnit: Double?
    let instruction: String?
    let contraIndication: String?
    let dose: String?
    let sideEffect: String?
    let overdose: String?
    let expiryDate: String?
    let fullName: String?
    let maker, status: Maker?
    let issueDate: String?
    let medicineFormula: String?
    let registrationCode: String?
    let tradeName: String?
    let thumbName: String?

    enum CodingKeys: String, CodingKey {
        case atc, barcode
        case pricePerUnit       = "price_per_unit"
        case instruction        = "instruction_text"
        case contraIndication   = "contraindication_text"
        case dose               = "dose_text"
        case sideEffect         = "side_effect_text"
        case overdose           = "overdose_text"
        case expiryDate         = "expiry_date"
        case fullName           = "full_name"
        case maker, status
        case issueDate          = "issue_date"
        case medicineFormula    = "medicine_formula"
        case registrationCode   = "registration_code"
        case tradeName          = "trade_name"
        case thumbName          = "thumb_name"
    }
}
