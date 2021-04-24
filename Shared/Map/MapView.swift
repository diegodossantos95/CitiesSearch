//
//  MapView.swift
//  CitiesSearch
//
//  Created by Diego Dos Santos on 23/04/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject private var viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.marker) { marker in
            marker.location
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel(coordinate: .init(latitude: -29.84720693303679, longitude: -51.15542427382699)))
    }
}
