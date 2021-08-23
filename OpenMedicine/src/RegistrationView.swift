//
//  RegistrationView.swift
//  RegistrationView
//
//  Created by Nurlan Nihonda on 23/8/21.
//

import SwiftUI

struct RegistrationView: View {
    typealias Value = Layout.Registration
    
    var body: some View {
        ZStack(alignment: .leading) {
            // background color
            Color(red: 0.9, green: 0.9, blue: 0.9)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: Value.FIELDS_PADDING) {
                Spacer()
                    .frame(height: Value.TOP_PADDING_RATIO)
                
                Text("Регистрация")
                    .font(.system(size: 36))
                
                Spacer()
                    .frame(height: Value.TOP_PADDING_RATIO)
                
                Spacer()
                
            }
            .padding(.horizontal, Value.HORIZONTAL_PADDING)
        }
        .frame(width: Screen.width)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

extension RegistrationView {
    private func onEmailChanged(_ text: String) {
        
    }
    
    private func onGenderChanged(_ text: String) {
        
    }
}
