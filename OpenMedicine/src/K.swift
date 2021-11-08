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
    static let HOST_API           = HTTP + "localhost:8081"
#else
    static let HOST_API           = HTTP + "34.88.132.245"
#endif
    
    class API {
        static let COATE_API    = K.HOST_API + "/api/v1/region-list"
        static let USER_API     = K.HOST_API + "/api/mobile/v1/store-user"
        static let CHECK_USER   = K.HOST_API + "/api/mobile/v1/user"
        static let NUMBER_TOTAL = K.HOST_API + "/api/mobile/v1/drug/num-of"
    }
    
    class Source {
        static let COATE            = "coate.json"
    }
}
