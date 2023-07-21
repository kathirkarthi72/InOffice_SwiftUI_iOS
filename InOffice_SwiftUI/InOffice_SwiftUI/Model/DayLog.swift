//
//  DayLog.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import Foundation
import SwiftData
import OSLog

fileprivate let logger = Logger(subsystem: "In Office", category: "DayLog")

@Model
final class DayLog: Identifiable {
    
    @Attribute(.unique) var startDate: Date
    var endDate: Date? = nil
    
    @Relationship(.cascade) var log: [DetailLog] = []
    
    var spends: TimeInterval = 0.0

    var note: String = ""
    
    init(startDate: Date, endDate: Date? = nil, log: [DetailLog] = [], spends: TimeInterval = 0.0, note: String = "") {
        self.startDate = startDate
        self.endDate = endDate
        self.log = log
        self.spends = spends
        self.note = note
    }
    
    func sortedLogs() -> [DetailLog] {
        let descriptor = SortDescriptor(\DetailLog.inTime, order: .forward)
        
        return log.sorted(using: descriptor)
    }
}

extension DayLog {
    
    /// Calculate total Spend
    /// - Returns: TimeInterval
    func calculateTotalSpend() -> TimeInterval {
        
        let totalSpend = log.compactMap({ $0.getSpend() }).reduce(0.0, +)
        return totalSpend
    }
}


extension Collection where Element == DayLog {
    
    /// Today Log filter.
    func todayLog() -> [DayLog] {
        let currentDate = Date()
        
        let from = currentDate.startOfDay
        let to = currentDate.endOfDay
        
        let todayPredicate = #Predicate<DayLog> { from < $0.startDate && $0.startDate < to }
        
        do {
            let result = try filter(todayPredicate)
            return result
            
        } catch let error {
            logger.error("Failed to filter today record from DayLog. Error: \(error.localizedDescription)")
//            print("Failed to filter today record from DayLog. Error: \(error.localizedDescription)")
        }
        
        return []
    }
    
    /// Today Log filter.
    func weekLog() -> [DayLog] {
        let currentDate = Date()
        
        let from = currentDate.startOfWeek
        let to = currentDate.endOfWeek
                
        let weekPredicate = #Predicate<DayLog> { from <= $0.startDate && to > $0.startDate }
        
        do {
            let result = try self.filter(weekPredicate)
            return result
            
        } catch let error {
            logger.error("Failed to filter weekLog record from DayLog. Error: \(error.localizedDescription)")
        }
        return []

    }
    
    /// Today Log filter.
    func monthLog() -> [DayLog] {
        let currentDate = Date()
        
        let from = currentDate.startOfMonth
        let to = currentDate.endOfMonth
        
        logger.info("Start: \(from), End: \(to)")

        let monthPredicate = #Predicate<DayLog> { from <= $0.startDate && to > $0.startDate }

        do {
            let result = try self.filter(monthPredicate)
            return result
            
        } catch let error {
            logger.error("Failed to filter monthLog record from DayLog. Error: \(error.localizedDescription)")
        }
        return []
    }
    
//    func allLog() -> [DayLog] {
////        let descriptor = FetchDescriptor<DayLog> ( sortBy: [SortDescriptor(\DayLog.startDate)] )
//        
////        do {
////            let allLog = try modelContext.fetch(descriptor)
////            return allLog
////        } catch let error {
////            print("Failed to filter weekLog record from DayLog. Error: \(error.localizedDescription)")
////        }
//        return self as! [DayLog]
//    }
}


/*
protocol DayLogSupportable {
    func isDayStarted() -> Bool
    func isDayClosed() -> Bool
}

extension DayLog: DayLogSupportable {
    
    func isDayStarted() -> Bool {
        return true
    }
    
    func isDayClosed() -> Bool {
        return true
    }
    
    
}
*/
