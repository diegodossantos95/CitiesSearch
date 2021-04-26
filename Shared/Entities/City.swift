//
//  City.swift
//  Shared
//
//  Created by Diego Dos Santos on 23/04/21.
//

import Foundation

struct City: Codable {
    var _id: Int
    var name: String
    var country: String
    var coord: Coordinate
}
