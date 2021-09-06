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
    static let HOST_API           = HTTP + "35.224.94.82:81"
#else
    static let HOST_API           = HTTPS + "tender-kg.info"
#endif
    
    class API {
        static let COATE_API = K.HOST_API + "/api/v1/region-list"
    }
}
