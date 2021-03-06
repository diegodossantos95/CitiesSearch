//
//  FileUtils.swift
//  CitiesSearch
//
//  Created by Diego Dos Santos on 26/04/21.
//

import Foundation

protocol FileUtilsProtocol {
    func readLocalFile(forName name: String) -> Data?
    func parse<T:Decodable>(jsonData: Data) -> T?
}

//TODO: create unit tests
struct FileUtils: FileUtilsProtocol {
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            //TODO: handle error
            print(error)
        }
        
        return nil
    }
    
    func parse<T:Decodable>(jsonData: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            //TODO: handle error
            print(error)
        }
        
        return nil
    }
}
