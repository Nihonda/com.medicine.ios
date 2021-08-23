//
//  Screen.swift
//  Screen
//
//  Created by Nurlan Nihonda on 23/8/21.
//

import UIKit

class Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    
    class Home {
        static let HORIZONTAL_PADDING = CGFloat(15)
    }
    
    class Keep {
        static let HORIZONTAL_PADDING = CGFloat(15)
    }
    
    class ResultCell {
        static let HORIZONTAL_PADDING = CGFloat(10)
    }
    
    // device flags
    static var isIpadDevice: Bool {
        return (UIDevice.current.userInterfaceIdiom == .pad)
    }
    
    static var isiPhoneXDevice: Bool {
        return UIScreen.main.bounds.height >= 812
    }
}
