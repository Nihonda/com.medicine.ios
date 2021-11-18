//
//  HomeView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 7/11/21.
//

import CodeScanner
import SwiftUI

struct BannerModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let image: String?
    let url: String
}

struct HomeView: View {
    @StateObject var numberVM = NumberViewModel()
    
    @State private var totalMedicine = "0"
    @State private var freewordBinding = ""
    
    @State var isShowingScanner = false
    @State var isDetailActive: Bool = false
    @State var barcode = ""
    
    private var banners: [BannerModel] = [
        BannerModel(name: "Департамент лекарственных средств и медицинских изделий при Министерстве здравоохранения Кыргызской Республики", image: "bnr_gerb", url: "http://pharm.kg")
    ]
    
    // variables
    private var blueColor = Color(.sRGB, red: 0, green: 0.64, blue: 1, opacity: 1)
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination:
                    DetailView(barcode: barcode)
                    .transition(.move(edge: .trailing)),
                isActive: $isDetailActive) {
                    EmptyView()
                }

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
                    .frame(height: Screen.isiPhoneXDevice ? 50 : 25)
                
                buttonsSubview
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr, .ean13, .code128], simulatedData: "", completion: handleScan)
        }
    }
    
    private var titleSubview: some View {
        HStack {
            Image("title_logo")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: Screen.width * 0.3)
        }
    }
    
    private var totalSubview: some View {
        HStack() {
            Text("Всего")
                .font(.system(size: 34))
                .padding(.trailing, 30)
            Text("\(numberVM.numberModel?.numOf.count ?? 0)")
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
            NavigationLink(destination: FreewordView()) {
                TextField("Поиск", text: $freewordBinding)
                    .disableAutocorrection(true)
                    .foregroundColor(freewordBinding == "" ? .gray : .primary)
                    .modifier(ClearButton(text: $freewordBinding))
                    .font(Font.system(size: 17))
                    .multilineTextAlignment(.leading)
                    .disabled(true)
            }
            Button(action: {
                isShowingScanner = true
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
                ForEach(banners) { model in
                    HStack(spacing: 10) {
                        if let image = model.image {
                            Image(image)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        }
                        if let text = model.name {
                            Text(text)
                                .font(.system(size: 20))
                        }
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

extension HomeView {
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let code):
            print("Found code: \(code)")
            self.barcode = code
            
            DispatchQueue.main.async {
                self.isDetailActive = true
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
