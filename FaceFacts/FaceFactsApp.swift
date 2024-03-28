//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Marco Zakaria on 27/03/2024.
//

import SwiftUI
import SwiftData

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
