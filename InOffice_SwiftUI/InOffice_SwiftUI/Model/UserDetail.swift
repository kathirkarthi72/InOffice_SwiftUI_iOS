//
//  User.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 24/07/23.
//

import Foundation
import SwiftData

@Model
final class UserDetail: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    var name: String = ""
    var dateOfBirth: Date = Date.now

    var email: String = ""
    var mobileNumber: String = ""
    
    @Relationship(.cascade) var companyDetail: CompanyDetail
  
    init(id: UUID = UUID(), name: String, dateOfBirth: Date, email: String, mobileNumber: String, companyDetail: CompanyDetail) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.email = email
        self.mobileNumber = mobileNumber
        self.companyDetail = companyDetail
    }
    
    init() {}
}

@Model
final class CompanyDetail: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    var name: String = ""
    var dateOfJoin: Date = Date.now
    var workingHours: String = ""
    var weeklyWorkingDays: String = ""
    
    init(id: UUID = UUID(), name: String, dateOfJoin: Date, workingHours: String, weeklyWorkingDays: String) {
        self.id = id
        self.name = name
        self.dateOfJoin = dateOfJoin
        self.workingHours = workingHours
        self.weeklyWorkingDays = weeklyWorkingDays
    }
    
    init() {}

}
