//
//  FileUtils.swift
//  CitiesSearch
//
//  Created by Diego Dos Santos on 26/04/21.
//

import Foundation

struct FileUtils {
    static func readLocalFile(forName name: String) -> Data? {
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
    
    static func parse<T:Decodable>(jsonData: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            print(error)
        }
        
        return nil
    }
}
