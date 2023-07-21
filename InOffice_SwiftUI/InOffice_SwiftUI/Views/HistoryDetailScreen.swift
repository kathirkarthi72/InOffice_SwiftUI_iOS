//
//  HistoryDetailScreen.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import SwiftUI
import SwiftData

struct HistoryDetailScreen: View {
    @Environment(\.modelContext) private var modelContext
    var dayLogs: DayLog
    
    var body: some View {
     
        List {
            Section {
                HStack {
                    Text("Total Spend in today")
                    Spacer()
                    Text(dayLogs.calculatedTotalSpend().stringFromTimeInterval())
                        .foregroundStyle(.green)
                }
                .font(.title3)
                .bold()
            }
            
            ForEach(dayLogs.sortedLogs()) { item in
                DetailCellView(detailLog: item)
            }
            
            .navigationTitle(Text(dayLogs.startDate, style: .date))
        }
    }
}

#Preview {
    NavigationView {
        HistoryDetailScreen(dayLogs: sampleLog)
            .modelContainer(for: DayLog.self, inMemory: true)
    }
  
}
