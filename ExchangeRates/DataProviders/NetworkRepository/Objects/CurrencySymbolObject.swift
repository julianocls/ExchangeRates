//
//  CurrencySymbolObject.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 15/08/23
//

import Foundation

struct CurrencySymbolObject: Codable {
    var base: String?
    var success: Bool = false
    var symbols: SymbolObject?

}

typealias SymbolObject = [String: String]
