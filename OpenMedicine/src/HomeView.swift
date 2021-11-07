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
                    .frame(height: Screen.isiPhoneXDevice ? 50 : 30)
                
                freewordSubview
                
                Spacer()
                    .frame(height: Screen.isiPhoneXDevice ? 50 : 25)
                
                bannerSubview
                
                Spacer()
                    .frame(height: Screen.isiPhoneXDevice ? 33 : 25)
                
                buttonsSubview
                
                Spacer()
            }
            .padding(.horizontal)
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
                .frame(width: Screen.width * 0.3)
                .border(Color.red)
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
    
    private var bannerSubview: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<5) { index in
                    HStack {
                        Text("Баннер \(index + 1)")
                            .font(.system(size: 28))
                    }
                    .frame(height: 170)
                    .frame(width: Screen.width - 40)
                    .background(Color(.systemGray3))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20).stroke(Color(.systemGray), lineWidth: 1)
                    )
                }
            }
        }
    }
    
    private var buttonsSubview: some View {
        HStack {
            Button(action: {
                
            }) {
                VStack {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)

                    Text("Карта")
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                }
                .frame(width: 160, height: 160)
            }
            .background(Color.white)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25).stroke(Color(.systemGray), lineWidth: 1)
            )
            
            Spacer()
            
            Button(action: {
                
            }) {
                VStack {
                    Image(systemName: "rectangle.and.text.magnifyingglass")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                    
                    Text("Поиск")
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                }
                .frame(width: 160, height: 160)
            }
            .background(Color.white)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25).stroke(Color(.systemGray), lineWidth: 1)
            )
        }
        .font(.system(size: 17))
        .foregroundColor(blueColor)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
                
                HomeView()
            }
        }
    }
}
