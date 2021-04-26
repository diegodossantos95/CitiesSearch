//
//  CityDataManager.swift
//  CitiesSearch
//
//  Created by Diego Dos Santos on 26/04/21.
//

import Foundation

//TODO: create protocol to improve test
struct CityDataManager {
    static func load() -> [City] {
        guard let data = FileUtils.readLocalFile(forName: "cities") else {
            //TODO: fallback
            return []
        }
        
        let items: [City]? = FileUtils.parse(jsonData: data)
        return items ?? []
    }
}
