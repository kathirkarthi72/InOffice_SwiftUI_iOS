//
//  HomeScreen.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import SwiftUI
import SwiftData
import OSLog

fileprivate let logger = Logger.init(subsystem: "InOffice", category: "Home")

enum VisitState {
    case stepIn
    case stepOut
    
    var name: String {
        if case .stepIn = self {
            return "In"
        }
        
        return "Out"
    }
    
    var icon: String {
        if case .stepIn = self {
            return "play.circle.fill"
        }
        
        return "pause.circle.fill"
    }
    
   mutating func toggle() {
        if self == .stepIn {
            self = .stepOut
        } else {
            self = .stepIn
        }
    }
    
    var foregroundColor: Color {
        if self == .stepIn {
            return .green
        } else {
            return .pink
        }
    }
}

struct HomeScreen: View {
    
    // SwiftModel
    @Environment(\.modelContext) private var modelContext
    @Query private var dayLogs: [DayLog]
    
    // Local veriables
    @State private var visitState: VisitState = .stepIn
    
    @State private var showCloseDayAlert: Bool = false
    
    func updateVisitState() {
        guard let lastLog = self.todayLog?.sortedLogs().last else {
            self.visitState = .stepIn
            return
        }
        
        guard lastLog.outTime != nil else {
            self.visitState = .stepOut
            return
        }
        
        self.visitState = .stepIn
    }
    
    private var todayLog: DayLog? {
        guard let todayLog = self.dayLogs.todayLog().last else { return nil }
        
//
//        if todayLog.log.last?.outTime == nil {
//            self.visitState = .stepOut
//        }
//        self.visitState = .stepIn
        
        return todayLog
    }
    
    var body: some View {
                
        NavigationView {
            
            VStack {
                
                if let todayLog = self.todayLog {
                    // Day Started.
                    List {
                        Section("Today") {
                            HStack {
                                Label("Date", systemImage: "clock")
                                Spacer()
                                Text(todayLog.startDate, style: .date)
                            }
                            
                            HStack {
                                Label("Day Started", systemImage: "clock")
                                Spacer()
                                Text(todayLog.startDate, style: .time)
                            }
                            
                            HStack {
                                Label("Expected ShiftOut", systemImage: "clock")
                                Spacer()
                                Text(Date.now, style: .time)
                            }
                            
                            HStack {
                                Label("Spend", systemImage: "clock")
                                Spacer()
                                Text(todayLog.spends.stringFromTimeInterval())
                            }
                        }
                        
                        Section {
                            NavigationLink {
                                HistoryScreen()
                            } label: {
                                Label("Work Log Book", systemImage: "list.bullet.circle")
                            }
                            
                        }
                    }
                    
                    Spacer(minLength: 10)
                    
                    Button {
                        // ShiftIn
                        withAnimation {
                            self.visitButtonTapped()
                        }
                        
                    } label: {
                        Image(systemName: visitState.icon)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)

                        // .foregroundColor(Color.themeColor1)
                    }.padding()
                        .foregroundColor(visitState.foregroundColor)
                    
                    
                        .toolbar {
                            ToolbarItem {
                                
                                Button(action: closeToday) {
                                    Label("Close", systemImage: "rectangle.portrait.and.arrow.right.fill")
                                }
                                .disabled(self.visitState == .stepOut)
                                .alert("Close the day ?", isPresented: $showCloseDayAlert) {
                                    Button("Cancel", role: .cancel, action: {})
                                    Button("Yes", role: .destructive) {
                                        // close today work.
                                        withAnimation {
                                            self.closeToday()
                                        }
                                    }
                                }
                            }
                        }
                    
                } else {
                    // Day not started.
                    VStack(alignment: .center, content: {
                        Spacer(minLength: 20)
                        
                        ZStack(content: {
                            Circle()
                                .frame(width: 200)
                                .foregroundStyle(Color.cyan)
                                .padding()
                            
                            Button(action: {
                                withAnimation {
                                    self.dayStarted()
                                }
                            }, label: {
                                Text("Start Work\nToday")
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.white)
                            })
                        })
                        
                        Text("Tap 'Start Work Today' Button before start ShiftIn.")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                            .foregroundStyle(Color.gray)
                        
                        Spacer()
                        
                        List {
                            NavigationLink {
                                HistoryScreen()
                            } label: {
                                Label("Work Log Book", systemImage: "list.bullet.circle")
                            }
                        }
                    })
                }
            }
            
            .onAppear {
                self.updateVisitState()

//                self.todayLog = self.dayLogs.todayLog().last
                
//                if self.todayLog?.log.last?.outTime == nil {
//                    self.visitState = .stepOut
//                }
//                self.visitState = .stepIn
            }
            
            .navigationTitle("In Office")
        }
    }
    
    
    /// Shift Button Tapped.
    func visitButtonTapped() {
        
        guard let todayLog = todayLog else { return }
        let currentDate = Date.now

        if case .stepIn = self.visitState { // Step In
            let log = DetailLog(inTime: currentDate, spend: 0.0)
            todayLog.log.append(log)
            
            self.visitState = .stepOut

        } else {
            guard let lastVisit = todayLog.sortedLogs().last else { return }
            
            let interval = lastVisit.inTime.timeIntervalSince(currentDate)
            lastVisit.outTime = currentDate
            lastVisit.setSpend(interval)
            
            self.updateTotalSpend(todayLog)
            
            self.visitState = .stepIn
        }
    }
    
    private func dayStarted() {
        logger.info("Day started")
//        self.todayLog = self.dayLogs.todayLog().last

        guard todayLog == nil else { return }
        
        let todayStarted = DayLog(startDate: Date.now)
        modelContext.insert(todayStarted)
        
//        self.todayLog = self.dayLogs.todayLog().last
    }
    
    fileprivate func updateTotalSpend(_ todayLog: DayLog) {
        logger.info("updateTotalSpend")

        let totalSpend = todayLog.sortedLogs().compactMap({ $0.getSpend() }).reduce(0.0, +)
        todayLog.spends = totalSpend
    }
    
    private func closeToday() {
        logger.info("closeToday")

        guard let todayLog = todayLog else { return }
        
        updateTotalSpend(todayLog)

        todayLog.endDate = Date()
        showCloseDayAlert.toggle()
        
    }
}

#Preview {
    
    NavigationView {
        HomeScreen()
    .modelContainer(for: DayLog.self)
    }
}



