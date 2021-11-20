//
//  MapView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 19/11/21.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var mapViewModel = MapViewModel()
    
    
    var body: some View {
        Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true)
            .accentColor(Color(.systemPink))
            .onAppear {
                mapViewModel.checkIfLocationServicesEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
                
                MapView()
            }
        }
    }
}
