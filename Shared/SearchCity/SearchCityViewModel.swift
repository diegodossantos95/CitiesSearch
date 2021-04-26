//
//  SearchCityViewModel.swift
//  CitiesSearch
//
//  Created by Diego Dos Santos on 23/04/21.
//

import Foundation
import Combine

class SearchCityViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var cityList = [City]()
    
    private var originaCityList = [City]()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        //TODO: Use injection dependency
        let items = CityDataManager.load()
        originaCityList.append(contentsOf: items)
        cityList.append(contentsOf: items)
        
        $searchText
            .sink (receiveValue: { [weak self] value in
                if let cityListWrap = self?.originaCityList {
                    self?.cityList = cityListWrap.filter({ value.isEmpty ? true : $0.name.starts(with: value) })
                }
            })
            .store(in: &subscriptions)
    }
}
