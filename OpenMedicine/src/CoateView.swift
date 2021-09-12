//
//  CoateView.swift
//  CoateView
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import SwiftUI

struct CoateView: View {
    @State var coate: CoateData?
    
    // default code
    let code = "41700000000000" // Kyrgyzstan all data
    
    var body: some View {
        VStack {
            if let coate = self.coate {
                OutlineGroup(coate.data, children: \.child) {item in
                    CoateCell(item: item)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, Layout.Registration.HORIZONTAL_PADDING)
        .onLoad {
            self.fetchCoate()
        }
        .navigationBarTitle("Выберите место проживания", displayMode: .inline)
    }
}

struct CoateView_Previews: PreviewProvider {
    static var previews: some View {
        CoateView()
    }
}

extension CoateView {
    private func fetchCoate() {
        let url = K.API.COATE_API
        let params = "code=\(code)"
        Api.shared.fetch(of: CoateData.self, from: [url, params].joined(separator: "?")) { result in
            switch result {
            case .failure(let error):
                print("[FAILED]: " + [url, params].joined(separator: "?"))
                print("\(error.localizedDescription)")
            case .success(let success):
                DispatchQueue.main.async {
                    self.coate = success
                    print("[SUCCESS]: \(success.data)")
                }
            }
        }
    }
}
