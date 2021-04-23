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
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(){
        //TODO: load json data
        
        $searchText
            .sink (receiveValue: { [weak self] value in
                if let cityListWrap = self?.cityList {
                    //TODO: use original city list to filter
                    self?.cityList = cityListWrap.filter({ value.isEmpty ? true : $0.name.starts(with: value) })
                }
                
                print("Last recieved: \(value)")
            })
            .store(in: &subscriptions)
    }
}
