//
//  CoateView.swift
//  CoateView
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import SwiftUI

struct CoateView: View {
    @EnvironmentObject var coate: CoateViewModel
    
    @State var isUpdated = true
    
    var body: some View {
        VStack {
            if isUpdated {
                if let parent = coate.data.data, let children = parent.child, children.count > 0 {
                    List{
                        OutlineGroup(parent, children: \.child) { item in
                            HStack(spacing: 15) {
                                Image(systemName: item.selected == true ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30, alignment: .center)
                                    .onTapGesture {
                                        triggerUpdate(for: item)
                                    }

                                Text(item.nm)
                                    .font(Font.system(size: 14))
                                
                                Spacer()
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
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
        NavigationView {
            CoateView()
        }
        .environmentObject(CoateViewModel())
    }
}

extension CoateView {
    private func triggerUpdate(for item: CoateItem) {
        item.selected?.toggle() ?? (item.selected = true)
        
        // hide/show OutlineGroup to trigger update event
        isUpdated = false
        DispatchQueue.main.async {
            self.isUpdated = true
        }
    }
}
