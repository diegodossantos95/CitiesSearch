//
//  CityDataManager.swift
//  CitiesSearch
//
//  Created by Diego Dos Santos on 26/04/21.
//

import Foundation

protocol CityDataManagerProtocol {
    func load() -> [City]
}

//TODO: use singleton
//TODO: create unit tests
struct CityDataManager: CityDataManagerProtocol {
    private var fileUtils: FileUtilsProtocol
    
    init(fileUtils: FileUtilsProtocol = FileUtils()) {
        self.fileUtils = fileUtils
    }
    
    func load() -> [City] {
        guard let data = self.fileUtils.readLocalFile(forName: "cities") else {
            //TODO: handle error
            return []
        }
        
        let items: [City]? = self.fileUtils.parse(jsonData: data)
        return items ?? []
    }
}
