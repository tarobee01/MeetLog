//
//  MeetLogApp.swift
//  MeetLog
//
//  Created by 武林慎太郎 on 2024/02/21.
//

import SwiftUI
import SwiftData

@main
struct MeetLogApp: App {
    let modelContainer: ModelContainer
    init() {
        do {
            modelContainer = try ModelContainer(for: User.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
        
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(modelContainer)
    }
}
