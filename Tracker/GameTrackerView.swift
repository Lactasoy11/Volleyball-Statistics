//
//  GameTrackerView.swift
//  Volleyball App
//
//  Created by E2617595 on 26/6/2568 BE.
//
//nsdlfjlaksdjlkgj

import SwiftUI

struct GameTrackerView: View {
    // MARK: – State
    @State private var players: [String] = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6", "Player 7"]
    @State private var selectedPlayerIndex: Int? = nil
    
    enum StatCategory: String, CaseIterable {
        case serveReceive = "Serve Receive"
        case blocking     = "Blocking"
        case setting      = "Setting"
        case attacks      = "Attacks"
        case serving      = "Serving"
        
        var options: [String] {
            switch self {
            case .serveReceive: return ["0","1","2","3"]
            case .blocking:     return ["Touch","Block","Error"]
            case .setting:      return ["Still in Play","Assist","Dump","Error"]
            case .attacks:      return ["Kill","Tip","Push","Error"]
            case .serving:      return ["0","1","2","Ace"]
            }
        }
    }
    
    // Tracks the current selection for each category
    @State private var statSelections: [StatCategory:String] = [:]
    
    // Grid layout helper
    private func gridColumns(count: Int) -> [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: count)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: – Body
                ScrollView {
                    HStack(alignment: .top, spacing: 16) {
                        
                        // Left column: Players
                        VStack(spacing: 12) {
                            ForEach(players.indices, id: \.self) { idx in
                                Button(action: {
                                    selectedPlayerIndex = idx
                                }) {
                                    Text(players[idx])
                                        .frame(width: 120, height: 44)
                                        .background(selectedPlayerIndex == idx
                                                    ? Color.accentColor.opacity(0.7)
                                                    : Color.gray.opacity(0.2))
                                        .foregroundColor(.primary)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.leading)
                        
                        // Right column: Stats
                        VStack(alignment: .leading, spacing: 24) {
                            ForEach(StatCategory.allCases, id: \.self) { category in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(spacing: 4) {
                                        Text(category.rawValue)
                                            .font(.headline)
                                        Image(systemName: "info.circle")
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                    }
                                    
                                    LazyVGrid(columns: gridColumns(count: category.options.count), spacing: 8) {
                                        ForEach(category.options, id: \.self) { option in
                                            Button(action: {
                                                statSelections[category] = option
                                            }) {
                                                Text(option)
                                                    .frame(maxWidth: .infinity, minHeight: 44)
                                                    .background(statSelections[category] == option
                                                                ? Color.accentColor.opacity(0.7)
                                                                : Color.gray.opacity(0.2))
                                                    .foregroundColor(.primary)
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            // Confirm button
                            HStack {
                                Spacer()
                                Button("Confirm") {
                                    // handle confirm
                                }
                                .frame(width: 120, height: 44)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                        .padding(.trailing)
                    }
                    .padding(.vertical)
                }
                
                // MARK: – Footer buttons
                HStack(spacing: 16) {
                    Button("Add Player") {
                        // handle add player
                    }
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button("End Game") {
                        // handle end game
                    }
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Game Tracker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Back button is automatic in a NavigationLink stack.
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Change Stats.") {
                        // handle change stats
                    }
                }
            }
        }
    }
}

struct GameTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        GameTrackerView()
    }
}
