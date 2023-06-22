//
//  CircleProgressView.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 13/06/23.
//

import SwiftUI

struct CircleProgressView: View {
    // 1
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.themeColor1.opacity(0.5),
                    lineWidth: 5
                )
            Circle()
                // 2
                .trim(from: 0, to: progress)
                .stroke(
                    Color.themeColor1,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

#Preview {
    CircleProgressView(progress: 0.5)
        .padding()
}
