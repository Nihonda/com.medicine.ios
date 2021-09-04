//
//  TextFieldArrowDown.swift
//  TextFieldArrowDown
//
//  Created by Nurlan Nihonda on 5/9/21.
//

import SwiftUI

struct TextFieldArrowDown: ViewModifier
{
    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content

            Image(systemName: "chevron.down")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(UIColor.opaqueSeparator))
                .padding(.trailing, 8)
        }
    }
}
