//
//  BaseCurrencyFilterView.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 5/6/23.
//

import Foundation
import Swift

extension BaseCurrencyFilterView {
    @MainActor class ViewModel: ObservableObject, CurrencySymbolsDataProviderDelegate {
        @Published var currencySymbols = [CurrencySymbolModel]()
        
        private let dataProvider: CurrencySymbolsDataProvider?
        
        init(dataProvider: CurrencySymbolsDataProvider = CurrencySymbolsDataProvider()) {
            self.dataProvider = dataProvider
            self.dataProvider?.delegate = self
        }
        
        func doFetchCurrencySymbol() {
            dataProvider?.fetchSymbols()
        }
        
        nonisolated func success(model: [CurrencySymbolModel]) {
            DispatchQueue.main.async {
                self.currencySymbols = model.sorted {$0.symbol < $1.symbol}
            }
        }
    }
}
