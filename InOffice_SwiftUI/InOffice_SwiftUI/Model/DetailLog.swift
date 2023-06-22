//
//  DetailLog.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import Foundation
import SwiftData

@Model
final class DetailLog: Identifiable {
        
    @Attribute(.unique) var inTime: Date
    var outTime: Date? = nil
    
    private var spend: TimeInterval = 0.0
    
    var note: String = ""
    
    init(inTime: Date, outTime: Date? = nil, spend: TimeInterval) {
        self.inTime = inTime
        self.outTime = outTime
        self.spend = spend
    }
  
}

extension DetailLog {
    
    /// Has Step out log updated
    /// - Returns: Bool Value
    func hasLogClosed() -> Bool {
        guard outTime != nil else { return false }
        
        return true
    }
    
    func setSpend(_ value: TimeInterval) {
        self.spend = value
    }
    
    func getSpend() -> TimeInterval {
        
        guard outTime != nil else {
            
            let currentDate = Date()
            let unRealisedSpend = inTime.timeIntervalSince(currentDate)
            
            return unRealisedSpend
        }
        return self.spend
    }
    
    func spendsInHours() -> String {
        return getSpend().stringFromTimeInterval()
    }
    
}
