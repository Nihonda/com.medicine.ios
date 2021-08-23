//
//  StartUpView.swift
//  StartUpView
//
//  Created by Nurlan Nihonda on 23/8/21.
//

import SwiftUI

struct StartUpView: View {
    let splashLogoRatio: CGFloat = 43/160
    
    var body: some View {
        ZStack {
            Color(red: 0, green: 163/255, blue: 1)
            
            VStack {
                Spacer()
                
                Image("logo")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Screen.width * splashLogoRatio)
                
                Spacer()
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct StartUpView_Previews: PreviewProvider {
    static var previews: some View {
        StartUpView()
    }
}
