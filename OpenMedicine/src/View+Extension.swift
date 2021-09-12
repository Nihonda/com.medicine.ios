//
//  View+Extension.swift
//  View+Extension
//
//  Created by Nurlan Nihonda on 12/9/21.
//

import SwiftUI

extension View {
    // viewDidLoad equivalent
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
