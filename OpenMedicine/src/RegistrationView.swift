//
//  RegistrationView.swift
//  RegistrationView
//
//  Created by Nurlan Nihonda on 23/8/21.
//

import SwiftUI

struct RegistrationView: View {
    typealias Value = Layout.Registration
    
    /*
     States
    */
    // email
    @State private var emailBinding: String = ""
    @State private var isEmailError: Bool = false
    
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
                
                VStack(spacing: 3) {
                    // email
                    HStack(alignment:.top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            TextField("example@gmail.com", text: self.$emailBinding.onChange(onEmailChanged))
                                .disableAutocorrection(true)
                                .font(Font.system(size: 16))
                                .frame(height: 30)
                                .padding(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.5))
                                )
                                .background(RoundedRectangle(cornerRadius: 10.0).fill(isEmailError ? Color(red: 0.93, green: 0.74, blue: 0.71, opacity: 1.0) : Color.white))
                            
                            VStack {
                                if isEmailError {
                                    Text("Проверьте правильность")
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .foregroundColor(.red)
                                        .padding(.leading)
                                }
                            }
                            .frame(height: 14)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
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
