//
//  RateHistoricalModel.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 5/6/23.
//

import Foundation

struct RateHistoricalModel: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var period: Date
    var endRate: Double
}
