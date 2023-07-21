//
//  HistoryScreen.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import SwiftUI
import SwiftData

enum FilterSegment: CaseIterable {
    case today
    case week
    case month
    case All
    
    var name: String {
        switch self {
        case .today:
            return "Today"
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .All:
            return "All"
        }
    }
    
}

struct HistoryScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var dayLogs: [DayLog]
    
    @State private var filterSegment: FilterSegment = .today
    
    private func filteredLog() -> [DayLog] {
        
        switch filterSegment {
        case .today:
            dayLogs.todayLog()
        case .week:
            dayLogs.weekLog()
        case .month:
            dayLogs.monthLog()
        case .All:
            dayLogs
        }
    }
    
    
    var body: some View {
        VStack {

            Picker("Filter", selection: $filterSegment, content: {
                ForEach(FilterSegment.allCases, id: \.self) {
                    Text($0.name)
                }
            })
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Spacer(minLength: 10)
            
            
            List {
                Section(filterSegment.name) {
                    
                    if !filteredLog().isEmpty {
                        //  NavigationStack {
                        ForEach(filteredLog(), id: \.self) { day in
                            NavigationLink {
                                HistoryDetailScreen(dayLogs: day)
                            } label: {
                                HStack {
                                    
                                    CircleProgressView(progress: 0.8)
                                                .frame(width: 40, height: 40)
                                    
                                    Text(day.startDate, style: .date)
                                    Spacer()
                                    Text(day.calculatedTotalSpend().stringFromTimeInterval())
                                        .foregroundColor(Color.themeColor1)
                                }
                            }
                        }
                        //                        }
                    }
                    
                }
            }
            .navigationTitle("History")
        }
    }
}

#Preview {
    NavigationView {
        HistoryScreen()
            .modelContainer(for: DayLog.self, inMemory: true)
    }
}
