//
//  CurrencySimbolsDataProvider.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 4/5/23.
//

import Foundation


protocol CurrencySymbolsDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: [CurrencySymbolModel])
}

class CurrencySymbolsDataProvider: DataProviderManager<CurrencySymbolsDataProviderDelegate, [CurrencySymbolModel]> {
    private let currencyStore: CurrencyStore
    
    init(currencyStore: CurrencyStore = CurrencyStore()) {
        self.currencyStore = currencyStore
    }
    
    func fetchSymbols() {
        Task.init {
            do {
                let model = try await currencyStore.fetchSymbols()
                delegate?.success(model: model.map({(key, value) -> CurrencySymbolModel in
                    return CurrencySymbolModel(symbol: key, fullName: value)
                }))
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
