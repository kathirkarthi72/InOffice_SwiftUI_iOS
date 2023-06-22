//
//  ClockScene.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 14/06/23.
//

import SwiftUI

struct ClockScene: View {
    @State var currentDate = Date.now
    
private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var dayCompond: Int {
        return Calendar.current.component(.day, from: currentDate)
    }
    
    private var monthCompond: Int {
        return Calendar.current.component(.month, from: currentDate)
    }
    
    private var yearCompond: Int {
        return Calendar.current.component(.year, from: currentDate)
    }
    
    private var hourCompond: Int {
        return Calendar.current.component(.hour, from: currentDate)
    }
    
    private var minCompond: Int {
        return Calendar.current.component(.minute, from: currentDate)
    }
    
    private var secCompond: Int {
        return Calendar.current.component(.second, from: currentDate)
    }
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Text(currentDate, style: .date)
                .font(.largeTitle)
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 250, height: 250)
                    .foregroundStyle(Color.green.opacity(0.4))
                
                                    
                Text("\(hourCompond)")
                    .font(Font.system(size: 200))
                    .fontWeight(.medium)
            }
            
            HStack(alignment: .bottom, spacing: 10.0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 250, height: 250)
                        .foregroundStyle(Color.pink.opacity(0.4))
                    
                    Text("\(minCompond)")
                        .font(Font.system(size: 150))
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 150, height: 150)
                        .foregroundStyle(Color.blue.opacity(0.4))
                    
                    Text("\(secCompond)")
                        .font(Font.system(size: 100))
                }
                .offset(y: 50)
            }
            .padding()
        }
        .onReceive(timer) { input in
            withAnimation {
                currentDate = input
            }
        }
    }
}



#Preview {
    ClockScene()
}

/*
 var body: some View {
     
     VStack(spacing: 10) {
         
         Text(currentDate, style: .date)
             .font(.largeTitle)
         
         ZStack {
             RoundedRectangle(cornerRadius: 25.0)
                 .frame(width: 250, height: 250)
                 .foregroundStyle(Color.green.opacity(0.4))
             
                                 
             Text("\(hourCompond)")
                 .font(Font.system(size: 200))
                 .fontWeight(.medium)
         }
         
         HStack(alignment: .bottom, spacing: 10.0) {
             ZStack {
                 RoundedRectangle(cornerRadius: 25.0)
                     .frame(width: 250, height: 250)
                     .foregroundStyle(Color.pink.opacity(0.4))
                 
                 Text("\(minCompond)")
                     .font(Font.system(size: 150))
             }
             
             ZStack {
                 RoundedRectangle(cornerRadius: 20)
                     .frame(width: 150, height: 150)
                     .foregroundStyle(Color.blue.opacity(0.4))
                 
                 Text("\(secCompond)")
                     .font(Font.system(size: 100))
             }
             .offset(y: 50)
         }
         .padding()
     }
     .onReceive(timer) { input in
         withAnimation {
             currentDate = input
         }
     }
 }
 */
