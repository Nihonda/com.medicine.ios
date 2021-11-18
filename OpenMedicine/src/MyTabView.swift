//
//  TabView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 18/11/21.
//

import SwiftUI

struct MyTabView: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(0)
            
            Text("Test")
                .tabItem {
                    Image(systemName: "star")
                }
                .tag(1)
            
            Text("Test")
                .tabItem {
                    Image(systemName: "book")
                }
                .tag(2)
        }
        .accentColor(Color(red: 3/255, green: 163/255, blue: 1))
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
