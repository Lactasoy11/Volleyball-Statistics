import SwiftUI

struct TeamBlockingOverall: View {
    var totalBlocks: Int {
        totalTouches + errorsTooled + successfulBlocks
    }
    var totalTouches = 3
    var errorsTooled = 3
    var successfulBlocks = 5

    var body: some View {
        VStack(spacing: 30) {
            Text("Blocking Overview")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)

            DonutChartView_Blocking(
                total: totalBlocks,
                touches: totalTouches,
                errors: errorsTooled,
                successful: successfulBlocks
            )

            VStack(spacing: 15) {
                StatBox(color: .green, label: "Block Touches", value: "\(totalTouches)")
                StatBox(color: .red, label: "Errors (Tooled)", value: "\(errorsTooled)")
                StatBox(color: .purple, label: "Successful Blocks", value: "\(successfulBlocks)")
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color.white)
    }
}

// MARK: - Donut Chart View (No Percentages)

struct DonutChartView_Blocking: View {
    var total: Int
    var touches: Int
    var errors: Int
    var successful: Int

    struct Segment {
        let start: Angle
        let end: Angle
        let color: Color
    }

    var body: some View {
        let values: [(value: Int, color: Color)] = [
            (touches, .green),
            (errors, .red),
            (successful, .purple)
        ]

        let radius: CGFloat = 130
        let totalDouble = Double(total)
        var startDeg: Double = 0

        let segments: [Segment] = values.map { item in
            let angle = Double(item.value) / totalDouble * 360
            let segment = Segment(
                start: .degrees(startDeg),
                end: .degrees(startDeg + angle),
                color: item.color
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
            }

            VStack {
                Text("\(total)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Total Blocks")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: radius * 2, height: radius * 2)
    }
}


#Preview {
    TeamBlockingOverall()
}
