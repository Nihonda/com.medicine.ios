//
//  DetailView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 15/11/21.
//

import SwiftUI

struct DetailView: View {
    @StateObject var vm = DownloadingDrugDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let barcode: String
    
    var body: some View {
        ZStack {
            bottomButtons
                .padding(.bottom)
                .zIndex(1)
            
            ScrollView {
                VStack(spacing: 20) {
                    if let name = vm.drugDetailItem?.detail.fullName {
                        Text(name)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                    }
                    
                    if let url = vm.drugDetailItem?.detail.thumbName {
                        DownloadingImageView(url: url, key: "1")
                            .frame(maxWidth: Screen.width * 3/4)
                    }
                    
                    shortIntro
                        .frame(maxWidth: .infinity)
                    
                    // https://www.vidal.ru/drugs/5-nok__5470
                    if let instruction = vm.drugDetailItem?.detail.instruction {
                        textContainer("Показания к применению", body: instruction)
                    }
                    
                    if let contraIndication = vm.drugDetailItem?.detail.contraIndication {
                        textContainer("Противопоказания к применению", body: contraIndication)
                    }
                    
                    if let dose = vm.drugDetailItem?.detail.dose {
                        textContainer("Режим дозирования", body: dose)
                    }
                    
                    if let sideEffect = vm.drugDetailItem?.detail.sideEffect {
                        textContainer("Побочное действие", body: sideEffect)
                    }
                    
                    if let overdose = vm.drugDetailItem?.detail.overdose {
                        textContainer("Дополнительно", body: overdose)
                    }
                }
                .padding()
                .padding(.bottom, 60)
            }
            .onAppear {
                vm.downloadData(barcode: barcode)
            }
            .navigationBarTitle("Подробно", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                            Text("Назад")
                        }
                    })
            )
        }
    }
    
    private var bottomButtons: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: {}) {
                    Text("Пожаловаться")
                        .foregroundColor(Color(.systemRed))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20).stroke(Color(.systemRed), lineWidth: 2)
                )
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 246/255, green: 251/255, blue: 255/255))
                )
                
                Button(action: {}) {
                    Text("Показать на карте")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBackground))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20).stroke(Color(.systemBackground), lineWidth: 2)
                )
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0, green: 164/255, blue: 255/255))
                )
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var shortIntro: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let price = vm.drugDetailItem?.detail.pricePerUnit {
                HStack(spacing: 5) {
                    Image(systemName: "dollarsign.circle.fill")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Text("\(price)")
                        .font(.system(size: 15))
                }
            }
            
            // medicine formula
            if let medicineFormula = vm.drugDetailItem?.detail.medicineFormula {
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "pills.fill")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text(medicineFormula)
                        .font(.system(size: 15))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            // maker
            if let maker = vm.drugDetailItem?.detail.maker?.nm {
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "house.circle.fill")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text(maker)
                        .font(.system(size: 15))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            // status
            if let status = vm.drugDetailItem?.detail.status?.nm {
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "allergens")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text("Статус: \(status)")
                        .font(.system(size: 15))
                }
            }
        }
    }
    
    private func textContainer(_ title: String, body: String) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 14))
                .fontWeight(.bold)
            Text(body)
                .font(.system(size: 13))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20).stroke(Color(.systemBackground), lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(uiColor: UIColor.systemBackground))
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
                
                DetailView(barcode: "1890104300078")
            }
            .navigationBarHidden(true)
        }
    }
}

extension DetailView {
    
}
