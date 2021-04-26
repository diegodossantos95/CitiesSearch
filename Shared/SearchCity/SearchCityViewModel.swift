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
        //TODO: sort the city list
        DispatchQueue.global(qos: .background).async { [weak self] in
            let items = CityDataManager.load()
            self?.originaCityList = items
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                self?.cityList = items
            }
        }

        $searchText
            .sink (receiveValue: { [weak self] value in
                DispatchQueue.global(qos: .background).async { [weak self] in
                    if let cityListWrap = self?.originaCityList {
                        //TODO: improve performance
                        let result = cityListWrap.filter({ value.isEmpty ? true : $0.name.starts(with: value) })
                        DispatchQueue.main.async { [weak self] in
                            self?.cityList = result
                        }
                    }
                }
            })
            .store(in: &subscriptions)
    }
}
