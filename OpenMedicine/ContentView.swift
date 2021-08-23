//
//  ContentView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 17/8/21.
//

import SwiftUI

struct ContentView: View {
    // states
    @State var isActive:Bool = false
    
    var body: some View {
        ZStack {
            if isActive {
                EmptyView()
            } else {
                StartUpView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
