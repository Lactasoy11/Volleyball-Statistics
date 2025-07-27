//
//  Volleyball_StatisticsApp.swift
//  Volleyball Statistics
//
//  Created by E2617773 on 15/7/2568 BE.
//

import SwiftUI

@main
struct Volleyball_StatisticsApp: App {
    var body: some Scene {
        WindowGroup {
               
            TeamStatsView(selectedTab: .constant(.teamStats))
            

        }
    }
}
