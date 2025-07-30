import SwiftUI

struct TeamSettingOverall: View {
    @Environment(\.dismiss) var dismiss



    var totalSets = 47
    var dumpErrors = 2
    var setErrors = 4
    var dumps = 8
    var inPlay = 5
    var assists = 6

    var errors: Int { dumpErrors + setErrors }
    var successfulSets: Int { totalSets - errors - dumps }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    Text("Setting Overview")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    DonutChartView(
                        total: totalSets,
                        errors: errors,
                        dumps: dumps,
                        successfulSets: successfulSets
                    )

                    VStack(spacing: 15) {
                        ExpandableStatBox(
                            color: .yellow,
                            label: "Errors",
                            value: "\(errors)",
                            subStats: [
                                ("Dump Error", "\(dumpErrors)"),
                                ("Set Error", "\(setErrors)")
                            ]
                        )

                        ExpandableStatBox(
                            color: .orange,
                            label: "Dumps",
                            value: "\(dumps)",
                            subStats: [
                                ("Dumps", "\(dumps)"),
                            ]
                        )

                        ExpandableStatBox(
                            color: .purple,
                            label: "Successful Sets",
                            value: "\(successfulSets)",
                            subStats: [
                                ("In Play", "\(inPlay)"),
                                ("Assist", "\(assists)")
                            ]
                        )
                        


                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("My Stats")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                    




                }
            }
        }
    }


struct DonutChartView: View {
    var total: Int
    var errors: Int
    var dumps: Int
    var successfulSets: Int

    struct Segment {
        let start: Angle
        let end: Angle
        let color: Color
        let percentLabel: String
        let labelPosition: CGPoint
    }

    var body: some View {
        let values: [(value: Int, color: Color, label: String)] = [
            (errors, .yellow, "Errors"),
            (dumps, .orange, "Dumps"),
            (successfulSets, .purple, "Success")
        ]

        let radius: CGFloat = 130
        let totalDouble = Double(total)
        var startDeg: Double = 0

        // Precompute segments
        let segments: [Segment] = values.map { item in
            let angle = Double(item.value) / totalDouble * 360
            let midDeg = startDeg + angle / 2
            let percent = Int((Double(item.value) / totalDouble * 100).rounded())

            // Label position (relative unit circle)
            let radians = midDeg * .pi / 180
            let x = cos(radians) * Double(radius) + Double(radius)
            let y = sin(radians) * Double(radius) + Double(radius)

            let segment = Segment(
                start: .degrees(startDeg),
                end: .degrees(startDeg + angle),
                color: item.color,
                percentLabel: "\(percent)%",
                labelPosition: CGPoint(x: x, y: y)
            )

            startDeg += angle
            return segment
        }

        return ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.15), lineWidth: 40)

            ForEach(0..<segments.count, id: \.self) { i in
                let seg = segments[i]

                DonutSegment(startAngle: seg.start, endAngle: seg.end, color: seg.color)

                Text(seg.percentLabel)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(seg.color)
                    .position(seg.labelPosition)
            }

            VStack {
                Text("\(total)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Total Sets")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: radius * 2, height: radius * 2)
    }
}


struct DonutSegment: View {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color

    var body: some View {
        Circle()
            .trim(from: CGFloat(startAngle.degrees / 360),
                  to: CGFloat(endAngle.degrees / 360))
            .stroke(color, style: StrokeStyle(lineWidth: 40, lineCap: .butt))
            .rotationEffect(.degrees(-90))
    }
}

struct StatBox: View {
    var color: Color
    var label: String
    var value: String

    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            Text(label)
                .font(.body)
                .foregroundColor(.black)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct ExpandableStatBox: View {
    var color: Color
    var label: String
    var value: String
    var subStats: [(String, String)]

    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Circle()
                        .fill(color)
                        .frame(width: 12, height: 12)
                    Text(label)
                        .font(.body)
                        .foregroundColor(.black)
                    Spacer()
                    Text(value)
                        .font(.body)
                        .foregroundColor(.gray)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                        .padding(.leading, 4)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }

            if isExpanded {
                VStack(spacing: 6) {
                    ForEach(subStats, id: \.0) { stat in
                        HStack {
                            Text(stat.0)
                                .font(.subheadline)
                            Spacer()
                            Text(stat.1)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 3)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 8)
            }
        }
    }
}

#Preview {
    TeamSettingOverall()
}
