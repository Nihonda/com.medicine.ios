//
//  CoateView.swift
//  CoateView
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import SwiftUI

struct CoateView: View {
    @State var coate: CoateData?
    
    var body: some View {
        VStack {
            if let coate = self.coate {
                OutlineGroup(coate.data, children: \.child) {item in
                    CoateCell(item: item)
                }
            }
        }
    }
}

struct CoateView_Previews: PreviewProvider {
    static var previews: some View {
        CoateView()
    }
}
