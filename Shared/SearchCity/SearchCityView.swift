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
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                } else {
                    CityListViewRepresentation(cityList: $viewModel.cityList)
                }
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
