//
//  K.swift
//  K
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import Foundation

class K {
    static let HTTP = "http://"
    static let HTTPS = "https://"
    
#if DEBUG
    static let HOST_API           = HTTP + "192.168.1.103:8081" // localhost
#else
    static let HOST_API           = HTTP + "34.88.132.245:81"
#endif
    
    class API {
        static let COATE_API    = K.HOST_API + "/api/v1/region-list"
        static let USER_API     = K.HOST_API + "/api/mobile/v1/store-user"
        static let CHECK_USER   = K.HOST_API + "/api/mobile/v1/user"
        static let NUMBER_TOTAL = K.HOST_API + "/api/mobile/v1/drug/num-of"
        static let DRUG_LIST    = K.HOST_API + "/api/mobile/v1/drug-list"
        static let DRUG_DETAIL  = K.HOST_API + "/api/mobile/v1/drug/detail"
        static let PLACE_LIST   = K.HOST_API + "/api/mobile/v1/drugstore"
        
        // simple schedules
        static let MNN_LIST     = K.HOST_API + "/api/mobile/v1/drug/mnn"
        static let ATC_LIST     = K.HOST_API + "/api/mobile/v1/drug/atc"
        static let FORM_LIST    = K.HOST_API + "/api/mobile/v1/drug/form"
        static let COUNTRY_LIST = K.HOST_API + "/api/mobile/v1/drug/country"
    }
    
    class Source {
        static let COATE            = "coate.json"
    }
}
