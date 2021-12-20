//
//  ViewDidLoadModifier.swift
//  ViewDidLoadModifier
//
//  Created by Nurlan Nihonda on 12/9/21.
//

import SwiftUI

// taken from
// https://stackoverflow.com/questions/56496359/swiftui-view-viewdidload#answer-64495887
struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}
