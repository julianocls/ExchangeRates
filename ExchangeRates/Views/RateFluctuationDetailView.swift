//
//  RateFluctuationDetailView.swift
//  ExchangeRates
//
//  Created by Juliano Santos on 16/5/23.
//

import SwiftUI

struct ChartComparation: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var period: Date
    var endDate: Double
}

class RateFluctuationViewModel: ObservableObject {
    @Published var fluctuations: [Fluctuation] = [
        Fluctuation(symbol: "JPY", change: 0.0008, changePct: 0.0005, endRate: 0.007242),
        Fluctuation(symbol: "EUR", change: 0.0003, changePct: 0.1651, endRate: 0.181353),
        Fluctuation(symbol: "GBP", change: -0.0001, changePct: -0.0403, endRate: 0.158915)
    ]
    @Published var chartComparations: [ChartComparation] = [
        ChartComparation(symbol: "USD", period: "2022-11-13".toDate(), endDate: 0.18857),
        ChartComparation(symbol: "USD", period: "2022-11-12".toDate(), endDate: 0.018857),
        ChartComparation(symbol: "USD", period: "2022-11-11".toDate(), endDate: 0.187786),
        ChartComparation(symbol: "USD", period: "2022-11-10".toDate(), endDate: 0.187073)
    ]
    
    @Published var timeRange = TimeRangeEnum.today
    
    var hasRates: Bool {
        return chartComparations.filter {$0.endDate > 0}.count > 0
    }
    
    var yAxisMin: Double {
        let min = chartComparations.map { $0.endDate }.min() ?? 0.0
        return (min - (min * 0.002))
    }
    
    var yAxisMax: Double {
        let max = chartComparations.map { $0.endDate }.min() ?? 0.0
        return (max + (max * 0.002))
    }
    
    func xAxisLabelFormatStyle(for date: Date) -> String {
        switch timeRange {
        case .today: return date.formatter(to: "HH:mm")
        case .thisWeek, .thisMonth: return date.formatter(to: "dd, MMM")
        case .thisSemester: return date.formatter(to: "MMM")
        case .thisYear: return date.formatter(to: "MMM, YYYY")
        }
    }
    
    func addFluctuation(fluctuation: Fluctuation) {
        fluctuations.insert(fluctuation, at: 0)
    }
    
    func removeFluctuations(fluctuation: Fluctuation) {
        if let index = fluctuations.firstIndex(of: fluctuation) {
            fluctuations.remove(at: index)
        }
    }
}

struct RateFluctuationDetailView: View {
    @StateObject var viewModel = RateFluctuationViewModel()
    @State var baseCurrency: String
    @State var rateFluctuation: Fluctuation
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            valuesView
            chartView
        }
        .navigationTitle("BRL a EUR")
    }
    
    private var valuesView: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(rateFluctuation.endRate.formatter(decimalPlaces: 4))
                .font(.system(size: 28, weight: .bold))
            
            Text(rateFluctuation.changePct.toPercentage(with: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(rateFluctuation.changePct.color)
                .background(rateFluctuation.changePct.color.opacity(0.2))
            
            Text(rateFluctuation.change.formatter(decimalPlaces: 4, with: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(rateFluctuation.change.color)
            
            Spacer()
        }
        .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
    }
    
    private var chartView: some View {
        VStack {
            periodFilterView
        }
    }
    
    private var periodFilterView: some View {
        HStack(spacing: 16) {            
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
    }
    
}

struct RateFluctuationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RateFluctuationDetailView(
            baseCurrency: "BRL",
            rateFluctuation: Fluctuation(symbol: "EUR", change: 0.0003, changePct: 0.1651, endRate: 0.181353)
        )
    }
}
