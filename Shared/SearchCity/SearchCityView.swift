//
//  SearchCityView.swift
//  Shared
//
//  Created by Diego Dos Santos on 22/04/21.
//

import SwiftUI

struct SearchCityView: View {
    @ObservedObject private var viewModel = SearchCityViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                List(viewModel.cityList, id: \.name, rowContent: { city in
                    NavigationLink(destination: MapView(viewModel: MapViewModel(coordinate: .init(latitude: city.coord.lat, longitude: city.coord.lon)))) {
                        VStack {
                            Text("\(city.name), \(city.country)")
                            Text("(\(city.coord.lon), \(city.coord.lat))")
                                .font(.subheadline)
                        }
                    }
                    
               })
                .listStyle(InsetListStyle())
            }
            .navigationBarTitle("Cities")
        }
    }
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCityView()
    }
}