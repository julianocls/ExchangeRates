//
//  RatesApi.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 15/08/23
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

struct RatesApi {
    
    static let baseUrl = "https://api.apilayer.com/exchangerates_data"
    static let apiKey = "eDWMD85vpCR0tXveGWa6gHa5AoznsYjj"
    static let fluctuation = "/fluctuation"
    static let symbols = "/symbols"
    static let timeseries = "/timeseries"
    
}
