//
//  MultiCurrenciesFilterViewViewModel.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 30/5/23.
//

import SwiftUI

struct MultiCurrenciesFilterView: View {

    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel = ViewModel()

    @State private var searchText = ""
    @State private var selections: [String] = []

    var searchResults: [CurrencySymbolModel] {
        if searchText.isEmpty {
            return viewModel.currencySymbols
        } else {
            return viewModel.currencySymbols.filter {
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.uppercased().contains(searchText.uppercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            listCurenciesView
        }
        .onAppear {
            viewModel.doFetchCurrencySymbol()
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
