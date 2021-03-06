//
//  TextFieldArrowDown.swift
//  TextFieldArrowDown
//
//  Created by Nurlan Nihonda on 5/9/21.
//

import SwiftUI

struct TextFieldArrow: ViewModifier
{
    @State var systemName: String
    
    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content

            Image(systemName: systemName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(UIColor.opaqueSeparator))
                .padding(.trailing, 8)
        }
    }
}
