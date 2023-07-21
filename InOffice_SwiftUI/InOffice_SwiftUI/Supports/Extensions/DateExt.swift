//
//  DateExt.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 11/06/23.
//

import Foundation

extension Date {
    func isToday() -> Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfWeek: Date {
        Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    var endOfWeek: Date {
        var components = DateComponents()
        components.weekOfYear = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfWeek)!
    }
    
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
}

extension TimeInterval {
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
//        return String(format: "%0.2d H %0.2d M %0.2d S",hours, minutes, seconds)

        
        var result: String = ""
        
        if hours > 0 {
            result = String(format: "%0.2d hours,",hours)
        }
        
        if minutes > 0 {
            result += String(format: " %0.2d min,",minutes)
        }
        
        if seconds == 0 {
            result += String(format: " %0.2d sec",seconds)
        } else {
            result += String(format: " %0.2d secs",seconds)
            
        }
        
        return result
        
    }
}
