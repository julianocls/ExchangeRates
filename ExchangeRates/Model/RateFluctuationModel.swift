//
//  RateFluctuationModel.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 5/6/23.
//

import Foundation

struct RateFluctuationModel: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var change: Double
    var changePct: Double
    var endRate: Double
}
