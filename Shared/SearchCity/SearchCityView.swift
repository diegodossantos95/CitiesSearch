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
                //TODO: add activity indicator
                SearchBar(text: $viewModel.searchText)
                CityListViewRepresentation(cityList: $viewModel.cityList)
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
