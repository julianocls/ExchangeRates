//
//  CurrencySymbolModel.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 5/6/23.
//

import Foundation

struct CurrencySymbolModel: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var fullName: String
}
