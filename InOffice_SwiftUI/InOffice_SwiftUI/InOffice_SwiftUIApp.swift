//
//  InOffice_SwiftUIApp.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import SwiftUI
import SwiftData

@main
struct InOffice_SwiftUIApp: App {
    
    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(for: Item.self)
        
        WindowGroup {
           CustomTabScene()
        }
        .modelContainer(for: [
            DayLog.self,
            DetailLog.self
        ])
    }
}



let sampleDetailLog: DetailLog = DetailLog(inTime: Date.now,
                                           outTime: Date().addingTimeInterval(60),
                                           spend: 60.0)


let sampleLog: DayLog = DayLog(startDate: Date.now,
                                  endDate: Date().addingTimeInterval(60),
                                  log: [sampleDetailLog],
                                  spends: 60.0, note: "")
