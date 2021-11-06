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
    static let HOST_API           = HTTP + "localhost:8081"//"35.224.94.82:81"
#else
    static let HOST_API           = HTTPS + "tender-kg.info"
#endif
    
    class API {
        static let COATE_API    = K.HOST_API + "/api/v1/region-list"
        static let USER_API     = K.HOST_API + "/api/mobile/v1/store-user"
        static let CHECK_USER   = K.HOST_API + "/api/mobile/v1/user"
    }
    
    class Source {
        static let COATE            = "coate.json"
    }
}
