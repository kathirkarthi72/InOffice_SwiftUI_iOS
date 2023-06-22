//
//  Item.swift
//  InOffice_SwiftUI
//
//  Created by Apple on 09/06/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
