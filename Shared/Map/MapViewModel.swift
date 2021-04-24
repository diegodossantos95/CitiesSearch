//
//  MapViewModel.swift
//  CitiesSearch
//
//  Created by Diego Dos Santos on 23/04/21.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var marker: [Marker]
    
    init(coordinate: CLLocationCoordinate2D){
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.2,
                longitudeDelta: 0.2
            )
        )
        
        marker = [Marker(location: MapMarker(coordinate: coordinate))]
    }
}

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}
