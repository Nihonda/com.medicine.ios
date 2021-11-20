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
        Map(coordinateRegion: $mapViewModel.region, annotationItems: mapViewModel.placeList) { place in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.latitude ?? 0, longitude: place.longitude ?? 0)) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(Color.blue)
                    Text(place.storeName)
                        .fixedSize()
                }
                .padding(10)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .overlay(
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(Color(.systemBackground))
                        .offset(y: 10)
                    , alignment: .bottom)
            }
        }
            .accentColor(Color(.systemPink))
            .onAppear {
                mapViewModel.checkIfLocationServicesEnabled()
                mapViewModel.downloadData(lat: 42.8834816, long: 74.5865216, dist: 1)
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
