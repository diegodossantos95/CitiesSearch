//
//  SearchCityView.swift
//  Shared
//
//  Created by Diego Dos Santos on 22/04/21.
//

import SwiftUI

struct SearchCityView: View {
    private let presenter = SearchCityPresenter()
    @State var searchText = ""
    @State var cityList = [City]()
    
    var body: some View {
        VStack {
            Text("Cities").font(.system(.title))
                .padding()
            SearchBar(text: $searchText)
                .padding(.bottom)
            List(cityList, id: \.name, rowContent: { city in
                Text(city.name)
           })
        }.onAppear {
            self.presenter.loadCities()
        }
    }
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCityView()
    }
}
