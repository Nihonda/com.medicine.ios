//
//  CoateView.swift
//  CoateView
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import SwiftUI

struct CoateCell: View {
    var item: CoateItem
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: item.selected == true ? "checkmark.circle.fill" : "checkmark.circle")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(height: 30, alignment: .center)
                .onTapGesture {
                    
                }
            
            Text(item.nm)
                .font(Font.system(size: 14))
            
            Spacer()
        }
    }
}

struct CoateCell_Previews: PreviewProvider {
    static var item = CoateItem(cd: 130, nm: "Иссык-Кульский район", code: "41702 215 000 00 0", capital_name: "г.Чолпон-Ата", capital_code: "41702 215 600 01 0", child: nil, selected: true, level: 0)
    
    static var previews: some View {
        CoateCell(item: item)
    }
}
