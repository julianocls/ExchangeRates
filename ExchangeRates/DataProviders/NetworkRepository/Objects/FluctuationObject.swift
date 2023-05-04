//
//  FluctuationObject.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 3/5/23.
//

import Foundation

typealias RatesFluctuationObject = [String: FluctuationObject]

struct FluctuationObject: Codable {
    
    let change: Double
    let changePct: Double
    let endRate: Double
    
    enum CodingKeys: String, CodingKey {
        case change
        case changePct = "change_pct"
        case endRate = "end_rate"
    }
}
