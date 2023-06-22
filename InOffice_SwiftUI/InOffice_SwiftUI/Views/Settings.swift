//
//  Settings.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import SwiftUI

/// User Settings
struct Settings: View {
    
    @State private var userName: String = ""
    
    @State private var companyName: String = ""

    @State private var joinedDate: Date = .now
    
    private var hours = ["8h", "9h", "10h"]
    @State private var workingHours: String = "1h"
    
    private var noOfdays = ["4 Days", "5 Days", "6 Days", "7 Days"]

    @State private var workingDays: String = "5"

    var body: some View {
        NavigationView {
            Form {
                
                IOCustomField(fieldName: "UserName", text: $userName)
                IOCustomField(fieldName: "Company Name", text: $companyName)
                
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
                
                .toolbar {
                    ToolbarItem {
                        Button(action: save) {
                            Text("Save")
                        }
                    }
                }
                
                .navigationTitle("Settings")
            }
            .formStyle(.grouped)
        }
        
      
    }
    
    private func save() {
        withAnimation {
            // Save to DB.
        }
    }
}

#Preview {
    NavigationView {
        Settings()
    }
}
