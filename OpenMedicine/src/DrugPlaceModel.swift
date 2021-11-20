//
//  PlaceModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 20/11/21.
//

import Foundation

struct DrugPlaceModel: Identifiable, Codable {
    let id: Int
    let code: String
    let registrationNumber: String
    let storeName: String
    let activity: String
    let regionName: String
    let regionId: Int
    let localityName: String
    let localityId: Int
    let sublocalityName: String
    let sublocalityId: Int
    let address: String
    let latitude: Double
    let longitude: Double
    let tel: String
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case code = "store_code"
        case registrationNumber = "registration_number"
        case storeName = "store_name"
        case activity = "store_activity"
        case regionName = "region_name"
        case regionId = "region_id"
        case localityName = "locality_name"
        case localityId = "locality_id"
        case sublocalityName = "sublocality_name"
        case sublocalityId = "sublocality_id"
        case address = "store_address"
        case latitude, longitude
        case tel = "contact_tel"
        case distance
    }
}
