//
//  RatesFluctuationView.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 9/5/23.
//

import SwiftUI

class FluctuationViewModel: ObservableObject {
    @Published var fluctuations: [RateFluctuationModel] = [
        RateFluctuationModel(symbol: "USD", change: 0.0008, changePct: 0.4175, endRate: 0.18857),
        RateFluctuationModel(symbol: "EUR", change: 0.0003, changePct: 0.1651,  endRate: 0.181353),
        RateFluctuationModel(symbol: "GBP", change: -0.0001, changePct: -0.0403, endRate: 0.158915)
    ]
}

struct RatesFluctuationView: View {
    @StateObject var viewModel = FluctuationViewModel()
    @State private var searchText = ""
    @State private var isPresentedBaseCurrencyFilterView = false
    @State private var isPresentedMultiCurrencyFilterView = false
    
    var searchResult: [RateFluctuationModel] {
        if searchText.isEmpty {
            return viewModel.fluctuations
        }
        return viewModel.fluctuations.filter {
            $0.symbol.contains(searchText.uppercased()) ||
            $0.change.formatter(decimalPlaces: 4).contains(searchText.uppercased()) ||
            $0.changePct.toPercentage().contains(searchText.uppercased()) ||
            $0.endRate.formatter(decimalPlaces: 2).contains(searchText.uppercased())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                baseCurrencyPeriodFilterView
                ratesFluctuationListView
            }
            .backgroundStyle(.red)
            .searchable(text: $searchText)
            .navigationTitle("Conversão de Moedas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isPresentedMultiCurrencyFilterView.toggle()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
                .fullScreenCover(isPresented: $isPresentedMultiCurrencyFilterView) {
                    MultiCurrenciesFilterView()
                }
            }
        }
    }
    
    private var baseCurrencyPeriodFilterView: some View {
        HStack(alignment: .center, spacing: 16) {
            Button {
                isPresentedBaseCurrencyFilterView.toggle()
            } label: {
                Text("BRL")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .foregroundColor(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                    }
            }
            .fullScreenCover(isPresented: $isPresentedBaseCurrencyFilterView, content: {
                BaseCurrencyFilterView()
            })
            .background(Color(UIColor.lightGray))
            .cornerRadius(8)
            
            Button {
                print("1 dia")
            } label: {
                Text("1 dia")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
            
            Button {
                print("7 dia")
            } label: {
                Text("7 dia")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
            
            Button {
                print("1 mês")
            } label: {
                Text("1 mês")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
                        
            Button {
                print("6 mês")
            } label: {
                Text("6 mês")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
            
            Button {
                print("1 ano")
            } label: {
                Text("1 ano")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
            
        }
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
    
    private var ratesFluctuationListView: some View {
        List(searchResult) { fluctuation in
            NavigationLink(destination: RateFluctuationDetailView(baseCurrency: "BRL", rateFluctuation: fluctuation)) {
                VStack {
                    HStack(alignment: .center, spacing: 8) {
                        Text("\(fluctuation.symbol) / BRL")
                            .font(.system(size: 14, weight: .medium))
                        Text("\(fluctuation.endRate.formatter(decimalPlaces: 2))")
                            .font(.system(size: 14, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text("\(fluctuation.change.formatter(decimalPlaces: 4, with: true))")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(fluctuation.change.color)
                        Text("(\(fluctuation.changePct.toPercentage()))")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(fluctuation.change.color)
                     }
                    Divider()
                        .padding(.leading, -20)
                        .padding(.trailing, -40)
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.white)
        }
        .listStyle(.plain)
    }
}

struct RatesFluctuationView_Previews: PreviewProvider {
    static var previews: some View {
        RatesFluctuationView()
    }
}
