//
//  ContentView.swift
//  Volleyball Statistics
//
//  Created by E2617773 on 15/7/2568 BE.
//

import SwiftUI

struct TeamStatsView: View {
    @Binding var selectedTab: TabSelection
    @State private var selectedStatsTab = "Overall Team Statistics"
    @State private var selectedMatch = "ISB vs TAS – July 15th 2025"
    @Environment(\.horizontalSizeClass) var sizeClass
  
    
    let matchOptions = [
        "ISB vs TAS – July 15th 2025",
        "ISB vs JIS – July 14th 2025",
        "ISB vs SAS – July 13th 2025"
    ]

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    // MARK: Top Banner
                    ZStack(alignment: .center) {
                        Color.black
                        HStack(spacing: -40) {
                            Image("est. 2024 (10)")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 140)
                                .opacity(0.07)
                                .offset(x: -30)
                            Spacer()
                         
                        }
                        VStack(spacing:-30) {
                            Text("ISB PANTHERS")
                                .font(Font.custom("Teko-Regular", size: 70))
                                .foregroundColor(.white)
                            Text("Men’s Varsity")
                                .font(Font.custom("Teko-Regular", size: 30))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .frame(height: 160)
                    .ignoresSafeArea(edges: .top)
                    // MARK: Tabs
                    HStack(spacing: 0) {
                        ForEach(["Overall Team Statistics", "Past Matches"], id: \.self) { tab in
                            Button(action: {
                                selectedStatsTab = tab
                            }) {
                                Text(tab)
                                    .font(Font.custom("Teko-Regular", size: 25))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(selectedStatsTab == tab ? Color.white : Color.gray.opacity(0.15))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .overlay(Divider(), alignment: .bottom)

                    // MARK: Conditional Content
                    if selectedStatsTab == "Overall Team Statistics" {
                        // Win / Lose row
                        HStack(spacing: 0) {
                            StatColumn(title: "Win", value: "15")
                            Divider().frame(height: 60)
                            StatColumn(title: "Lose", value: "5")
                        }
                        .padding()
                        .background(Color.white)

                        Divider()

                        Spacer().frame(height: 30)
                    }else {
                        ZStack(alignment: .top) {
                            // Match title and placeholder space
                            VStack(spacing: 0) {
                                Spacer().frame(height: 80) // height reserved only for title text
                                Text(selectedMatch)
                                    .font(Font.custom("Teko-Regular", size: 40))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                            }

                            // Floating dropdown on top
                            Dropdown(selected: $selectedMatch, options: matchOptions)
                                .zIndex(999)
                        }
                        .id(selectedStatsTab)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 16)
                        .zIndex(10)
                    }
                    // MARK: Stat Grid
                    let stats = getStats(for: selectedStatsTab)
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 0) {
                        ForEach(stats) { stat in
                            NavigationLink(destination: stat.destinationView) {
                                ZStack(alignment: .topLeading) {
                                    // Background icon
                                    Image(stat.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120) // ⬅️ Bigger size
                                        .offset(x: sizeClass == .compact ? -20 : -90, y: 30) // ⬅️ Shift more to the left

                                    VStack(alignment: .center, spacing: -10) {
                                        Spacer()
                                        
                                        Text(stat.value)
                                            .font(Font.custom("Teko-Regular", size: 60))
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                        
                                        if sizeClass == .compact {
                                            // iPhone or narrow screen: wrap manually
                                            let lines = stat.title.components(separatedBy: " ")
                                            VStack(spacing: -20) {
                                                ForEach(lines, id: \.self) { word in
                                                    Text(word)
                                                }
                                            }
                                            .multilineTextAlignment(.center)
                                            .font(Font.custom("Teko-Regular", size: 30))
                                            .foregroundColor(.gray)
                                        } else {
                                            // iPad or wide screen: show in one line
                                            Text(stat.title)
                                                .font(Font.custom("Teko-Regular", size: 40))
                                                .foregroundColor(.gray)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.5)
                                        }
                                    }
                                    .padding()

                                }
                                .frame(width: geo.size.width / 3, height: 160)
                                .background(Color.white)
                                .border(Color.gray.opacity(0.1), width: 0.5)
                                .clipped()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }

                    Spacer()

                    // MARK: Bottom Tab Bar
                    HStack(spacing: 50) {
                        Button(action: {
                                selectedTab = .myStats
                            }) {
                                Image(systemName: "person")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    
                            }

                            Button(action: {
                                selectedTab = .teamStats
                            }) {
                                Image(systemName: "person.3.fill")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }

                            Button(action: {
                                selectedTab = .newGame
                            }) {
                                Image(systemName: "plus.circle")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                    }
                    .padding()
                    .frame(width: 320)
                    .background(Color.white)
                    .cornerRadius(35)
                    .shadow(radius: 3)
                    .padding(.bottom, 25)
                }
                .background(Color(.systemGray6))
            }
        }
    }

    func getStats(for tab: String) -> [StatItem] {
        if tab == "Overall Statistics" {
            return [
                StatItem(title: "Serve Reception", value: "82%", imageName: "est. 2024 (10)", destinationView: AnyView(TeamServeReceptionOverall())),
                    StatItem(title: "Defending", value: "75%", imageName: "est. 2024 (10) copy", destinationView: AnyView(TeamDefendingOverall())),
                    StatItem(title: "Attacking", value: "95%", imageName: "est. 2024 (10) copy 4", destinationView: AnyView(TeamAttackingOverall())),
                    StatItem(title: "Setting Errors", value: "4", imageName: "est. 2024 (10) copy 3", destinationView: AnyView(TeamSettingOverall())),
                    StatItem(title: "Blocks", value: "8", imageName: "est. 2024 (10) copy 2", destinationView: AnyView(TeamBlockingOverall())),
                    StatItem(title: "Serving", value: "86%", imageName: "est. 2024 (12) copy 2", destinationView: AnyView(TeamServingOverall()))
            ]
        } else {
            return [
                StatItem(title: "Serve Reception", value: "82%", imageName: "est. 2024 (10)", destinationView: AnyView(TeamServeReceptionOverall())),
                    StatItem(title: "Defending", value: "75%", imageName: "est. 2024 (10) copy", destinationView: AnyView(TeamDefendingOverall())),
                    StatItem(title: "Attacking", value: "95%", imageName: "est. 2024 (10) copy 4", destinationView: AnyView(TeamAttackingOverall())),
                    StatItem(title: "Setting Errors", value: "4", imageName: "est. 2024 (10) copy 3", destinationView: AnyView(TeamSettingOverall())),
                    StatItem(title: "Blocks", value: "8", imageName: "est. 2024 (10) copy 2", destinationView: AnyView(TeamBlockingOverall())),
                    StatItem(title: "Serving", value: "86%", imageName: "est. 2024 (12) copy 2", destinationView: AnyView(TeamServingOverall()))
            ]
        }
    }
}

// MARK: - Support Views and Models
struct StatColumn: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: -20) {
            Text(value)
                .font(Font.custom("Teko-Regular", size: 60))
                .fontWeight(.bold)
            Text(title)
                .font(Font.custom("Teko-Regular", size: 30))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct StatItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let imageName: String
    let destinationView: AnyView
}

struct Dropdown: View {
    @Binding var selected: String
    let options: [String]
    @State private var isExpanded = false

    var body: some View {
        ZStack(alignment: .top) {
            Button {
                withAnimation { isExpanded.toggle() }
            } label: {
                HStack {
                    Text(selected)
                        .font(Font.custom("Teko-Regular", size: 28))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(0)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
            }

            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            selected = option
                            withAnimation { isExpanded = false }
                        } label: {
                            Text(option)
                                .font(Font.custom("Teko-Regular", size: 24))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                        .background(Color.white)
                        .buttonStyle(.plain)

                        Divider()
                    }
                }
                .background(Color.white)
                .cornerRadius(1)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                .offset(y: 55) // dropdown opens below the button
            }
        }
        .frame(maxWidth: 300)
        .zIndex(2)
    }
}

struct ContentView: View {
    @State private var selectedTab: TabSelection = .teamStats

    var body: some View {
        switch selectedTab {
        case .myStats:
            MyStatsView(selectedTab: $selectedTab)
        case .teamStats:
            TeamStatsView(selectedTab: $selectedTab)
        case .newGame:
            NewGame(selectedTab: $selectedTab)
        }
    }
}


enum TabSelection {
    case myStats
    case teamStats
    case newGame
}

#Preview {
    ContentView()
}
