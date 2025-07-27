import SwiftUI

struct TeamPageView: View {
    @State private var players: [String] = Array(repeating: "", count: 10)
    @State private var jerseyNumbers: [String] = Array(repeating: "", count: 10)

    var body: some View {
        ZStack(alignment: .top) {
            // Gradient background only at the top
            LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(red: 227/255, green:226/255, blue: 255/255)]),
                           startPoint: .top,
                           endPoint: .center)
                .frame(height: 200)
                .ignoresSafeArea(edges: .top)

            VStack(spacing: 20) {
                // Header section — no background, shows gradient
                Text("Team Name")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white) // make text readable on gradient
                    .padding(.top, 60) // push below notch
                    .padding(.bottom, 20)

                // Main content section with white background
                ScrollView{
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("No.")
                                .frame(width: 30, alignment: .leading)
                                .fontWeight(.semibold)

                            Text("Player name")
                                .frame(maxWidth: .infinity,
                                           alignment: .leading)
                                .fontWeight(.semibold)
                        }

                        ForEach($players.indices, id: \.self) { index in
                            HStack {
                                TextField("", text: $jerseyNumbers[index])
                                    .keyboardType(.numberPad) // optional: number-only keyboard
                                    .multilineTextAlignment(.center)
                                    .frame(width: 30, height: 30)
                                    .background(RoundedRectangle(cornerRadius: 5).stroke())
                                TextField("Player name", text: $players[index])
                                    .autocorrectionDisabled(true)
                                    .padding(5)
                                    .background(RoundedRectangle(cornerRadius: 5).stroke())
                            }
                        }

                        // Invite Button
                        Button(action: {
                            players.append("")
                            jerseyNumbers.append("")
                        }) {
                            HStack {
                                Text("Add")
                                Image(systemName: "plus")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 76/255, green:116/255, blue: 255/255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 20)
                    }
                }
                
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .offset(y: -20) // slight overlap on gradient

                Spacer()

                // Bottom Tab Bar
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "person")
                        Text("My Stats").font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person.3")
                        Text("Team Stats").font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "plus.circle")
                        Text("New Game").font(.caption)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
            }
        }
    }
}

// Extension to round only top corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct TeamPageView_Previews: PreviewProvider {
    static var previews: some View {
        TeamPageView()
    }
}
//
//  TeamPage.swift
//  Volleyball Statistics
//
//  Created by E2617929 on 27/7/2568 BE.
//

