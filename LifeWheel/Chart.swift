//
//  SwiftUIView.swift
//  SwiftUITest
//
//  Created by Юра Сорокин on 30.04.2022.
//

import SwiftUI

struct Chart: View {

    var sectors: Int
    var segments: Int

    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                let _ = print("loc: \(gesture.location)")
            }
    }

    var body: some View {
        GeometryReader { geometry in
            let edge = min(geometry.size.width, geometry.size.height)
            let degrees = 360/Double(sectors)

            ZStack {
                ForEach(0..<sectors, id: \.self) { index in
                    let rotationDegrees = degrees * CGFloat(index)
                    let textDegrees = rotationDegrees - degrees/2
                    let isOut = textDegrees < 90 || textDegrees > 270

                    LabeledCircleSector(model: .init(
                        circleModel: .init(
                            color: .random,
                            angle: .init(degrees: degrees),
                            segments: segments,
                            filledSegments: Int.random(in: 0..<segments)
                        ),
                        text: "text \(index)",
                        isOut: isOut,
                        fontSize: 50
                    ))
                    .rotationEffect(.init(degrees: rotationDegrees), anchor: .topLeading)
//                    .contentShape(Rectangle())
//                    .gesture(drag)
                }
            }
            .scaleEffect(0.5, anchor: .bottomTrailing)
            .frame(width: edge, height: edge)

        }
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(sectors: 8, segments: 10)
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

