//
//  CustomTabScene.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 13/06/23.
//

import SwiftUI
import SwiftData

struct CustomTabScene: View {
    @State private var selectedTab = "One"
    
    @Environment(\.modelContext) private var modelContext
    @Query private var userDetails: [UserDetail]

    var body: some View {
    
        TabView(selection: $selectedTab) {
            if hasMyDetailAvailable {
                
                HomeScreen()
                    .tabItem {
                        // no Record = clock.fill
                        // inprogress = clock.badge.exclamationmark.fill
                        // Completed = clock.badge.checkmark.fill
                        Label("At Office", systemImage: "building.2.crop.circle")
                    }
                    .tag("One")
            }
            
            Settings()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag("Two")
            
            ClockScene()
                .tabItem {
                    Label("Clock", systemImage: "clock.circle.fill")
                }
            
          
        }
        .tint(Color.themeColor1)
    }
    
    private var hasMyDetailAvailable: Bool {
        
        let users = self.userDetails
        
        return users.count > 0
    }
}

#Preview {
    CustomTabScene()
}
