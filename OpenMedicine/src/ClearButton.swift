//
//  ClearButton.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 7/11/21.
//

import SwiftUI

import SwiftUI

struct ClearButton: ViewModifier
{
    @Binding var text: String

    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content

            if !text.isEmpty
            {
                Button(action:
                {
                    self.text = ""
                })
                {
                    Image(systemName: "delete.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
    }
}
