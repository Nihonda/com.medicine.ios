//
//  HomeView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 7/11/21.
//

import SwiftUI

struct HomeView: View {
    @State private var totalMedicine = "0"
    @State private var freewordBinding = ""
    
    // variables
    private var blueColor = Color(.sRGB, red: 0, green: 0.64, blue: 1, opacity: 1)
    
    var body: some View {
        ZStack {
            VStack {
                titleSubview
                
                Spacer()
                    .frame(height: 30)
                
                totalSubview
                
                Spacer()
                    .frame(height: 50)
                
                freewordSubview
                
                Spacer()
                    .frame(height: 50)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    private var titleSubview: some View {
        HStack {
            Image("title_logo")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
        }
    }
    
    private var totalSubview: some View {
        HStack() {
            Text("Всего")
                .font(.system(size: 34))
                .padding(.trailing, 30)
            Text(totalMedicine)
                .font(.system(size: 48))
                .foregroundColor(blueColor)
                .padding(.trailing, 5)
            Image("pill")
                .resizable()
                .renderingMode(.original)
                .frame(width: 36, height: 36)
            
            Spacer()
        }
    }
    
    private var freewordSubview: some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: 40)
            TextField("Поиск", text: $freewordBinding)
                .disableAutocorrection(true)
                .foregroundColor(freewordBinding == "" ? .gray : .primary)
                .modifier(ClearButton(text: $freewordBinding))
                .font(Font.system(size: 17))
            Button(action: {
                print("works")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 25)
                    .padding()
            }
            .foregroundColor(Color(uiColor: UIColor.systemBackground))
            .background(blueColor)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            .frame(height: 20)
            .foregroundColor(Color(.systemGray))
            .padding()
        )
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15).stroke(Color(.systemGray), lineWidth: 2)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
