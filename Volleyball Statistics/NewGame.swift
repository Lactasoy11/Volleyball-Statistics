import SwiftUI

// MARK: - New Game Screen as the main ContentView
struct NewGame: View {
    @Binding var selectedTab: TabSelection
    @State private var selectedTeam = "ISB - Varsity"
    @State private var gameDate = Date()
    @State private var opponent = ""
    @State private var selectedStats: Set<String> = []

    let teams = ["ISB - Varsity", "ISB - JV", "Other Team..."]
    let stats = ["Serve Receive", "Digging", "Serving",
                 "Attacks", "Setting", "Blocks",
                 "Rotations", "etc.", "etc."]
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                // Team Picker
                Text("Team")
                    .font(.subheadline).bold()
                Picker("", selection: $selectedTeam) {
                    ForEach(teams, id: \.self) { Text($0) }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(height: 44)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5))
                )

                // Date & Time Picker
                Text("Date and Time")
                    .font(.subheadline).bold()
                DatePicker("", selection: $gameDate, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()



                // Opponent TextField
                Text("Opponent")
                    .font(.subheadline).bold()
                TextField("Team Name", text: $opponent)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5))
                    )

                // Stats Selection
                Text("What statistics do you want to track today?")
                    .font(.footnote)
                    .multilineTextAlignment(.center)

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(stats, id: \.self) { stat in
                        Button(action: {
                            if selectedStats.contains(stat) {
                                selectedStats.remove(stat)
                            } else {
                                selectedStats.insert(stat)
                            }
                        }) {
                            Text(stat)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, minHeight: 44)
                                .foregroundColor(
                                    selectedStats.contains(stat) ? .white : .black
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(
                                            selectedStats.contains(stat)
                                            ? Color.blue
                                            : Color.purple.opacity(0.4)
                                        )
                                )
                        }
                    }
                }

                // Enter Button
                Button(action: {
                    // Handle enter logic here
                }) {
                    Text("Enter")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("New Game")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button("Cancel") {
                selectedTab = .teamStats
            })
        }
    }
}

// MARK: - Preview
struct NewGame_Previews: PreviewProvider {
    static var previews: some View {
        NewGame(selectedTab: .constant(.newGame))
    }
}
