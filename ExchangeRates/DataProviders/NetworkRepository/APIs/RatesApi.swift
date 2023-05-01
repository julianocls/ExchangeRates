//
//  RatesApi.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 1/5/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

struct RatesApi {
    static let baseUrl = "https://api.apilayer.com/exchangerates_data"
    static let apiKey = "OoCmhuke4biQgor7gqT8npLBLrfcwN8V"
    static let symbols = "/symbols"
    static let timeseries = "/timeseries"
    static let fluctuation = "/fluctuation"
}
