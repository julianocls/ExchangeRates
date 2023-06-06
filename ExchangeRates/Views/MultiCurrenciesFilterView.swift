//
//  MultiCurrenciesFilterViewViewModel.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 30/5/23.
//

import SwiftUI

class MultiCurrenciesFilterViewViewModel: ObservableObject {
    @Published var symbols: [CurrencySymbolModel] = [
        CurrencySymbolModel(symbol: "BRL", fullName: "Brazilian Real"),
        CurrencySymbolModel(symbol: "EUR", fullName: "Euro"),
        CurrencySymbolModel(symbol: "GBP", fullName: "British Pound Sterling"),
        CurrencySymbolModel(symbol: "JPY", fullName: "Japanese Yen"),
        CurrencySymbolModel(symbol: "USD", fullName: "United States Dollar")
    ]
}

struct MultiCurrenciesFilterView: View {

    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel = MultiCurrenciesFilterViewViewModel()

    @State private var searchText = ""
    @State private var selections: [String] = []

    var searchResults: [CurrencySymbolModel] {
        if searchText.isEmpty {
            return viewModel.symbols
        } else {
            return viewModel.symbols.filter {
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.uppercased().contains(searchText.uppercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            listCurenciesView
        }
    }

    private var listCurenciesView: some View {
        List(searchResults, id: \.symbol) { item in
            Button {
                if selections.contains(item.symbol) {
                    selections.removeAll { $0 == item.symbol }
                } else {
                    selections.append(item.symbol)
                }
            } label: {
                HStack {
                    HStack {
                        Text(item.symbol)
                            .font(.system(size: 14, weight: .bold))
                        Text("-")
                            .font(.system(size: 14, weight: .semibold))
                        Text(item.fullName)
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    Image(systemName: "checkmark")
                        .opacity(selections.contains(item.symbol) ? 1.0 : 0.0)
                    Spacer()
                }
            }
            .foregroundColor(.primary)
        }
        .searchable(text: $searchText)
        .navigationTitle("Filtrar Moedas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                dismiss()
            } label: {
                Text("OK")
                    .fontWeight(.bold)
            }
        }
    }
}

struct CurrencySelectionFilterView_Previews: PreviewProvider {
    static var previews: some View {
        MultiCurrenciesFilterView()
    }
}
