//
//  CoateView.swift
//  CoateView
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import SwiftUI

struct CoateView: View {
    @EnvironmentObject var coate: CoateViewModel
    
    var body: some View {
        VStack {
            if let coate = self.coate.data.data {
                OutlineGroup(coate, children: \.child) {item in
                    CoateCell(item: item)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, Layout.Registration.HORIZONTAL_PADDING)
        .onLoad {
            
        }
        .navigationBarTitle("Выберите место проживания", displayMode: .inline)
    }
}

struct CoateView_Previews: PreviewProvider {
    static var previews: some View {
        CoateView()
    }
}

extension CoateView {
    
}
