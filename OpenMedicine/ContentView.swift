//
//  ContentView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 17/8/21.
//

import SwiftUI

struct ContentView: View {
    // states
    @State var isActive:Bool = false
    @StateObject var coate = CoateViewModel()
    
    @AppStorage("uuid") var uuid: String = ""
    
    // region default code
    let code = "41700000000000" // Kyrgyzstan all data
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
                
                if isActive {
                    if uuid.isEmpty {
                        RegistrationView()
                            .transition(AnyTransition.opacity.animation(.easeInOut))
                    } else {
                        HomeView()
                    }
                } else {
                    StartUpView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                     self.isActive = true
                }
                
                if Files.shared.exists(K.Source.COATE) {
                    self.coate.data.data = self.readCoate()?.data
                } else {
                    self.fetchCoate()
                }
            }
        }
        .environmentObject(coate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
    private func fetchCoate() {
        let url = K.API.COATE_API
        let params = "code=\(code)"
        Api.shared.fetch(of: CoateData.self, from: [url, params].joined(separator: "?")) { result in
            switch result {
            case .failure(let error):
                print("[FAILED]: " + [url, params].joined(separator: "?"))
                print("\(error.localizedDescription)")
            case .success(let data):
                DispatchQueue.main.async {
                    Files.shared.write(filename: K.Source.COATE, item: data)
                    self.coate.data = data
                    print("[SUCCESS]: \(data)")
                }
            }
        }
    }
    
    private func readCoate() -> CoateData? {
        return Files.shared.read(filename: K.Source.COATE)
    }
}
