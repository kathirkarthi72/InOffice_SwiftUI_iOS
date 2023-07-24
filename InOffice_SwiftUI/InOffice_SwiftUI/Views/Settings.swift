//
//  Settings.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import SwiftUI
import SwiftData

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
        
    

    var body: some View {
        
        NavigationView {
            
            List {
                Section("Personal Detail", isExpanded: $expandPersonalSection, content: {
                    
                    IOCustomField(fieldName: "Name", text: $userName)
                    
                    DatePicker(selection: $joinedDate, displayedComponents: .date) {
                        Text("Date of Birth")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color.themeColor1)
                    }
                    .padding(.vertical)
                    
                    IOCustomField(fieldName: "Email", text: $email)
                    
                    IOCustomField(fieldName: "Mobile number", text: $mobileNumber)
                })
                
                Section(isExpanded: $expandCompanySection, content:  {
                    
                    IOCustomField(fieldName: "Company Name", text: $companyName)
                    
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
                
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {
                        //
                    }, label: {
                        Text("Save")
                    })
                    Spacer()
                }
            }
            
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
            
            var myDetail = getMyDetail()
            
            userName = myDetail.name
            dob = myDetail.dateOfBirth
            
            email = myDetail.email
            mobileNumber = myDetail.mobileNumber
            
            companyName = myDetail.companyDetail.name
            joinedDate = myDetail.companyDetail.dateOfJoin
            
            workingHours = myDetail.companyDetail.workingHours
            workingDays = myDetail.companyDetail.weeklyWorkingDays
        }
      
    }
    
    
    private func getMyDetail() -> UserDetail {
        
        guard let myLog = self.userDetails.first else {
            
            let new = UserDetail()
            modelContext.insert(new)

            return new
        }
        return myLog
    }
    
    private func save() {
        
        let myDetail = getMyDetail()

        myDetail.name = userName
        myDetail.dateOfBirth = dob
        
        myDetail.email = email
        myDetail.mobileNumber = mobileNumber
        
        myDetail.companyDetail.name = companyName
        myDetail.companyDetail.dateOfJoin = joinedDate
        
        myDetail.companyDetail.workingHours = workingHours
        myDetail.companyDetail.weeklyWorkingDays = workingDays
    }
    
}

#Preview {
    
    NavigationView {
        Settings()
            .modelContainer(for: UserDetail.self)
    }
}
