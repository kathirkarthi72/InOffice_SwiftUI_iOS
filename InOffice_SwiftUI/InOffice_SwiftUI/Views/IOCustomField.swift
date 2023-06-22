//
//  IOCustomField.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import SwiftUI

struct IOCustomField: View {
    var fieldName: String = ""
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(fieldName)
                .font(.title3)
                .bold()
                .foregroundStyle(Color.themeColor1)
            
            TextField(text: $text) {
                Text("")
            }
            .padding(.all, 5.0)
            .frame(height: 45)
            .border(Color.gray, width: 0.5)
        }
    }
}
//
//#Preview {
//    @State var text = "new"
//    IOCustomField(fieldName: "Username", text: $text)
//}
