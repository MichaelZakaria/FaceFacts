//
//  Event.swift
//  FaceFacts
//
//  Created by Marco Zakaria on 28/03/2024.
//

import Foundation
import SwiftData

@Model
class Event {
    var name: String
    var Location: String
    var people = [Person]()
    
    init(name: String, Location: String) {
        self.name = name
        self.Location = Location
    }
}
