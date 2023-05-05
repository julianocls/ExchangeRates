//
//  CurrencySimbolsDataProvider.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 4/5/23.
//

import Foundation


protocol CurrencySimbolsDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: CurrencySymbolObject)
}

class CurrencySimbolsDataProvider: DataProviderManager<CurrencySimbolsDataProviderDelegate, CurrencySymbolObject> {
    private let currencyStore: CurrencyStore
    
    init(currencyStore: CurrencyStore = CurrencyStore()) {
        self.currencyStore = currencyStore
    }
    
    func fetchSymbols() {
        Task.init {
            do {
                let model = try await currencyStore.fetchSymbols()
                delegate?.success(model: model)
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
