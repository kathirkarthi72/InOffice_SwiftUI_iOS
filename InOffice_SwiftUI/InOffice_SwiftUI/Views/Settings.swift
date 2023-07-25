//
//  Settings.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import SwiftUI
import SwiftData
import OSLog

/// User Settings
struct Settings: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var userDetails: [UserDetail]
    
    @State private var expandPersonalSection: Bool = true
    @State private var expandCompanySection: Bool = true
    
    // Personal
    @State private var userName: String = ""
    @State private var dob: Date = .now

    @State private var email: String = ""
    @State private var mobileNumber: String = ""

    // Company
    @State private var companyName: String = ""

    @State private var joinedDate: Date = .now
    
    private var hours = ["8", "9", "10"]
    @State private var workingHours: String = "8"
    
    private var noOfdays = ["4", "5", "6", "7"]

    @State private var workingDays: String = "5"
    
    private let logger = Logger(subsystem: "Settings", category: "InOffice_SwiftUI")
    
    @State private var isSavedUIVisible: Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack(content: {
                List {
                    Section("Personal Detail", isExpanded: $expandPersonalSection, content: {
                        
                        IOCustomField(fieldName: "Name", text: $userName)
                            .keyboardType(.alphabet)
                        
                        DatePicker(selection: $dob, displayedComponents: .date) {
                            Text("Date of Birth")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.themeColor1)
                        }
                        .padding(.vertical)
                        
                        IOCustomField(fieldName: "Email", text: $email)
                            .keyboardType(.emailAddress)
                        
                        IOCustomField(fieldName: "Mobile number", text: $mobileNumber)
                            .keyboardType(.numberPad)
                    })
                    
                    Section(isExpanded: $expandCompanySection, content:  {
                        
                        IOCustomField(fieldName: "Company Name", text: $companyName)
                            .keyboardType(.alphabet)

                        Picker(selection: $workingDays) {
                            ForEach(noOfdays, id: \.self) {
                                Text($0)
                            }
                        } label: {
                            Text("Weekly working days")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.themeColor1)
                        }
                        .padding(.vertical)

                        DatePicker(selection: $joinedDate, displayedComponents: .date) {
                            Text("Joined Date")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.themeColor1)
                        }
                        .padding(.vertical)
                        
                        Picker(selection: $workingHours) {
                            ForEach(hours, id: \.self) {
                                Text($0)
                            }
                        } label: {
                            Text("Daily working hours")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.themeColor1)
                        }
                        .padding(.vertical)
                    }, header: {
                        Text("Company Detail")
                    })
                }
                
                if isSavedUIVisible {
                    Button(action: {
                        withAnimation(.spring) {
                            isSavedUIVisible.toggle()
                        }
                    }, label: {
                        VStack(alignment: .center, spacing: 10.0) {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                               
                            Text("Saved")
                        }
                        .padding(20)
                        .background(.thinMaterial)
                        .cornerRadius(5.0)
                    })
                   
                }
            })
            
            .toolbar {
                ToolbarItem {
                    Button(action: save) {
                        Text("Save")
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        .onAppear {
                        
            let myDetail = getMyDetail()
             
            self.userName = myDetail.name
            self.dob = myDetail.dateOfBirth
             
            self.email = myDetail.email
            self.mobileNumber = myDetail.mobileNumber
             
            self.companyName = myDetail.companyDetail.name
            self.joinedDate = myDetail.companyDetail.dateOfJoin
             
            self.workingHours = myDetail.companyDetail.workingHours
            self.workingDays = myDetail.companyDetail.weeklyWorkingDays
        }
    }
    
    private func getMyRecordAvailableInDB() -> Bool {
        let users = self.userDetails
        return users.count > 0
    }
    
    private func getMyDetail() -> UserDetail {
        if getMyRecordAvailableInDB() {
            return self.userDetails.first!
        } else {
            let new = UserDetail()
            logger.debug("get: \(new.description)")
            
            return new
        }
    }
    
    private func save() {
        
        let myDetail = getMyDetail()
        
        logger.debug("get: \(myDetail.description)")

        myDetail.name = self.userName
        myDetail.dateOfBirth = self.dob
        
        myDetail.email = self.email
        myDetail.mobileNumber = self.mobileNumber
        
        myDetail.companyDetail.name = self.companyName
        myDetail.companyDetail.dateOfJoin = self.joinedDate
        
        myDetail.companyDetail.workingHours = self.workingHours
        myDetail.companyDetail.weeklyWorkingDays = self.workingDays
        
        if !getMyRecordAvailableInDB() {
            modelContext.insert(myDetail)
        }
                      
        withAnimation(.spring) {
            isSavedUIVisible = true
        }
        
        
    }
    
}

#Preview {
    
    NavigationView {
        Settings()
            .modelContainer(for: UserDetail.self)
    }
}
