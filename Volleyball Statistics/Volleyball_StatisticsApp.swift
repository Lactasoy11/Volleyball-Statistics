//
//  Volleyball_StatisticsApp.swift
//  Volleyball Statistics
//
//  Created by E2617773 on 15/7/2568 BE.
//

import SwiftUI

@main
struct Volleyball_StatisticsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
               
            TeamStatsView(selectedTab: .constant(.teamStats))
            

        }
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
