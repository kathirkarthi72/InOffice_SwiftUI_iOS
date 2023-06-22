//
//  DetailCellView.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 13/06/23.
//

import SwiftUI
import SwiftData

struct DetailCellView: View {
    
    var detailLog: DetailLog = .init(inTime: Date(), spend: 100)
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 10.0) {
                Text("In Time")
                Text("Out Time")
                Text("Spend")
            }
            
//            Divider()
            
            VStack(alignment: .leading, spacing: 10.0) {
                Text(detailLog.inTime, style: .time)

                if let outTime = detailLog.outTime {
                    Text(outTime, style: .time)
                } else {
                    Text("..")
                }

                Text(detailLog.spendsInHours())
            }
            .foregroundStyle(.themeColor1)
        }
    }
}


#Preview {
    DetailCellView()
        .previewLayout(PreviewLayout.fixed(width: 80, height: 200))
        .modelContainer(for: DetailLog.self, inMemory: true)
}
