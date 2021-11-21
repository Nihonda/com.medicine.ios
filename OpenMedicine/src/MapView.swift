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
    @State var isShowingPinDetails = false
    @State var pinPlace: DrugPlaceModel? = nil
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapViewModel.region, annotationItems: mapViewModel.placeList) { place in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.latitude ?? 0, longitude: place.longitude ?? 0)) {
                    HStack {
                        Image(systemName: "pills.fill")
                            .foregroundColor(Color.blue)
                        Text(place.storeName)
                            .fixedSize()
                    }
                    .padding(10)
                    .font(.system(size: 12))
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .overlay(
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundColor(Color(.systemBackground))
                            .offset(y: 10)
                        , alignment: .bottom)
                    .onTapGesture {
                        pinPlace = place
    
                        withAnimation(.easeInOut) {
                            isShowingPinDetails = true
                        }
                    }
                }
            }
            
            if isShowingPinDetails {
                pinSubview
            }
        }
        .accentColor(Color(.systemPink))
        .navigationBarTitle("Карта", displayMode: .inline)
        .onAppear {
            mapViewModel.checkIfLocationServicesEnabled()
            mapViewModel.downloadData(lat: 42.8834816, long: 74.5865216, dist: 1)
        }
    }
    
    private var pinSubview: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                if let place = pinPlace {
                    Text(place.storeName)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    
                    Text(place.activity)
                    
                    HStack {
                        Text(place.address)
                        Spacer()
                        if let distance = place.distance {
                            Text(String(format: "%.0fm", (distance * 1000)))
                        }
                    }
                    
                    if let phone = place.tel, !phone.isEmpty, let url = URL(string: "tel:\(phone)") {
                        HStack {
                            Spacer()
                            Link("Звонить: \(phone)", destination: url)
                                .font(.system(size: 14))
                                .foregroundColor(Color(.link))
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .padding()
            .font(.system(size: 12))
            .foregroundColor(Color.primary)
            .background(Color(.systemBackground))
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
