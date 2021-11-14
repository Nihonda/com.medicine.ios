//
//  DrugListRow.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 12/11/21.
//

import SwiftUI

struct DrugListRow: View {
    
    let model: DrugItem
    
    var body: some View {
        HStack {
            if let image = model.thumbName {
                DownloadingImageView(url: image, key: model.id)
                    .frame(maxWidth: Screen.width * 0.3)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(model.fullName.orEmpty)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                if let price = model.pricePerUnit {
                    HStack(spacing: 5) {
                        Image(systemName: "dollarsign.circle.fill")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                        Text("\(price)")
                    }
                }
                
                // medicine formula
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "pills.fill")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text(model.medicineFormula.orEmpty)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                // maker
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "house.circle.fill")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text((model.maker?.nm).orEmpty)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                //
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "allergens")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text("Статус:")
                    Text((model.status?.nm).orEmpty)
                }
                
                // license
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "exclamationmark.circle")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text("Срок лицензии:")
                    Text(model.expiryDate.orEmpty)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .font(.system(size: 13))
    }
}

struct DrugListRow_Previews: PreviewProvider {
    static var previews: some View {
        DrugListRow(model: DrugItem(atc: Atc(cd: 1, nm: "Atc name", nmEng: "English name"), barcode: "1000000022222", expiryDate: "2021-11-15", fullName: "Medicine for everyone LTD", maker: Maker(cd: 1, nm: "Kyrgyzstan"), status: Maker(cd: 1, nm: "Approved"), issueDate: "2020-02-02", pricePerUnit: 500.00, medicineFormula: "Interesting medicine formula", thumbName: "https://storage.googleapis.com/openmedicine-323603.appspot.com/images/1890104300111.jpg"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
