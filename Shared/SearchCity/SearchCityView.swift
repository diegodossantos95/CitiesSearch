//
//  SearchCityView.swift
//  Shared
//
//  Created by Diego Dos Santos on 22/04/21.
//

import SwiftUI

struct SearchCityView: View {
    @ObservedObject private var viewModel = SearchCityViewModel()
    @State var isMapActive = false
    @State var selectedCity: City?

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MapView(viewModel: MapViewModel(coordinate: .init(latitude: selectedCity?.coord.lat ?? 0, longitude: selectedCity?.coord.lon ?? 0))), isActive: $isMapActive) {
                }
                SearchBar(text: $viewModel.searchText)
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                } else {
                    CityListViewRepresentation(cityList: $viewModel.cityList, didSelectRowAt: { row in
                        selectedCity = viewModel.cityList[row]
                        isMapActive = true
                    })
                }
            }
            .navigationBarTitle("Cities")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCityView()
    }
}
