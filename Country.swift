//
//  Country.swift
//  Consolidation6
//
//  Created by Venkata on 2/12/24.
//

import Foundation

struct Country: Codable {
    var country: String
}

struct City: Codable {
    var country: String
    var city: String?
}

struct CurrencyCode: Codable {
    var country: String
    var currency_code: String?
}

struct Population: Codable {
    var country: String
    var population: Int?
}

struct Area: Codable {
    var country: String
    var area: Double?
}
