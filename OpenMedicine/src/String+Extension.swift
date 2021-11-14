//
//  String+Extension.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 14/11/21.
//

import UIKit

extension String {
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed).orEmpty
    }
    
    var decodeUrl : String
    {
        return self.removingPercentEncoding.orEmpty
    }
}
