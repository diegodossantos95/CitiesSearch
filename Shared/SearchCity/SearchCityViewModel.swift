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
    @Published var isLoading = true
    @Published var selectedCity: City?
    
    private var originaCityList = [City]()
    private var subscriptions = Set<AnyCancellable>()
    private var cityDataManager: CityDataManagerProtocol
    
    init(cityDataManager: CityDataManagerProtocol = CityDataManager()) {
        self.cityDataManager = cityDataManager
        self.isLoading = true
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            var items = self.cityDataManager.load()
            items.sort { ($0.name, $0.country) < ($1.name, $1.country) }
            self.originaCityList = items
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) { [weak self] in
                guard let self = self else { return }
                self.cityList = items
                self.isLoading = false
            }
        }

        $searchText
            .sink (receiveValue: { [weak self] value in
                DispatchQueue.global(qos: .background).async { [weak self] in
                    guard let self = self else { return }
                    //TODO: improve performance
                    let result = self.originaCityList.filter({ value.isEmpty ? true : $0.name.starts(with: value) })
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.cityList = result
                    }
                }
            })
            .store(in: &subscriptions)
    }
}
