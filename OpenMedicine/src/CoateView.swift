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
    @AppStorage("coate_item") var coateItem: Data = Data()
    
    var body: some View {
        VStack {
            if isUpdated {
                if let parent = coate.data.data, let children = parent.child, children.count > 0 {
                    List{
                        OutlineGroup(parent, children: \.child) { item in
                            HStack(spacing: 15) {
                                Image(systemName: item.selected == true ? "checkmark.circle.fill" : childSelected(item) ? "circle.circle" : "circle")
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30, alignment: .center)
                                    .onTapGesture {
                                        restoreDefaults(parent: parent)
                                        triggerUpdate(for: item)
                                        saveItem(item)
                                    }

                                Text(item.nm)
                                    .font(Font.system(size: 14))
                                    .foregroundColor(Color.primary)
                                
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
        .onAppear {
            restoreItem()
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
    private func restoreDefaults(parent: CoateItem) {
        // clear
        parent.selected = nil
        
        if let children = parent.child {
            for child in children {
                restoreDefaults(parent: child)
            }
        }
    }
    
    private func triggerUpdate(for item: CoateItem) {
        item.selected?.toggle() ?? (item.selected = true)
        
        // hide/show OutlineGroup to trigger update event
        isUpdated = false
        DispatchQueue.main.async {
            self.isUpdated = true
        }
    }
    
    private func saveItem(_ item: CoateItem) {
        guard let data = try? JSONEncoder().encode(item) else { return }
        coateItem = data
    }
    
    private func childSelected(_ item: CoateItem) -> Bool {
        if let children = item.child {
            let items = children.filter({ $0.selected == true })
            if items.count > 0 {
                return true
            } else {
                var selected = false
                for child in children {
                    selected = childSelected(child)
                    if selected {
                        return selected
                    }
                }
                return selected
            }
        }

        return false
    }
    
    private func setItem(_ item: CoateItem, target: CoateItem, with: Bool) {
        if item.cd == target.cd {
            item.selected = true
            return
        }
        
        if let children = item.child {
            for child in children {
                setItem(child, target: target, with: true)
            }
        }
    }
    
    private func restoreItem() {
        guard let item = try? JSONDecoder().decode(CoateItem.self, from: coateItem) else { return }
        
        // clear
        if let parent = coate.data.data {
            restoreDefaults(parent: parent)
            
            // set
            isUpdated = false
            setItem(parent, target: item, with: true)

            DispatchQueue.main.async {
                self.isUpdated = true
            }
        }
    }
}
