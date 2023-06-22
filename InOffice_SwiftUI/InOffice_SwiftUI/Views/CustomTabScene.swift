//
//  CustomTabScene.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 13/06/23.
//

import SwiftUI

struct CustomTabScene: View {
    @State private var selectedTab = "One"

    var body: some View {
    
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tabItem {
                    // no Record = clock.fill
                    // inprogress = clock.badge.exclamationmark.fill
                    // Completed = clock.badge.checkmark.fill
                    Label("Home", systemImage: "clock.badge.checkmark.fill")
                }
                .tag("One")
            
            ClockScene()
                .tabItem {
                    Label("Clock", systemImage: "clock.circle.fill")
                }
            
            Settings()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag("Two")
        }
        .tint(Color.themeColor1)
    }
}

#Preview {
    CustomTabScene()
}
