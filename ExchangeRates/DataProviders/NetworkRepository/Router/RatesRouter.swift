//
//  RatesRouter.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 1/5/23.
//

import Foundation

enum RatesRouter {
    
    case fluctuation(base: String, symbols: [String], startDate: String, endDate: String)
    case timeseries(base: String, symbols: [String], startDate: String, endDate: String)
    
    var path: String {
        switch self {
        case .fluctuation:
            return RatesApi.fluctuation
        case .timeseries:
            return RatesApi.timeseries
        }
    }
    
    func asUrlRequest() throws -> URLRequest? {
        guard var url = URL(string: RatesApi.baseUrl) else { return nil }
        
        switch self {
        case .fluctuation(let base, let symbols, let startDate, let endDate):
            setUrlQueryItems(&url, base, symbols, startDate, endDate)
        case .timeseries(let base, let symbols, let startDate, let endDate):
            setUrlQueryItems(&url, base, symbols, startDate, endDate)
        }
        
        var request = URLRequest(url: url.appendingPathComponent(path), timeoutInterval: Double.infinity)
        request.httpMethod = HttpMethod.get.rawValue
        request.addValue(RatesApi.apiKey, forHTTPHeaderField: "apikey")
        return request
    }
    
    fileprivate func setUrlQueryItems(_ url: inout URL, _ base: String, _ symbols: [String], _ startDate: String, _ endDate: String) {
        url.append(queryItems: [
            URLQueryItem(name: "base", value: base),
            URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate)
        ])
    }
}
