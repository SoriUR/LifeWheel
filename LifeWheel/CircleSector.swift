//
//  CirclePart.swift
//  SwiftUITest
//
//  Created by Юра Сорокин  on 30.04.2022.
//

import SwiftUI

extension CircleSector {
    struct Model {
        let color: Color
        let angle: Angle
        let segments: Int
        var filledSegments: Int
    }
}

struct CircleSector: View {

    init(model: Model) {
        self.model = model
    }

    @State private var model: Model
    @State private var step: CGFloat = .zero
    @State private var edge: CGFloat = .zero

    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                let position = gesture.location
                let radius = calculateRadius(point: position)

                let p = calculateX(radius: position.y, radians: model.angle.radians)

                let b = calculateRadius(point: .init(x: 0, y: edge))

                guard
                    position.x >= 0,
                    position.y >= 0,
                    position.x <= p,
                    radius <= b
                else { return }

                let segments = min(Int(radius/step) + 1, model.segments)
                model.filledSegments = segments
            }
    }

    @ViewBuilder
    func geometryReader() -> some View {
        if step == .zero || edge == .zero {
            GeometryReader { geometry -> Color in
                DispatchQueue.main.async {
                    edge = min(geometry.size.width, geometry.size.height)
                    step = edge / CGFloat(model.segments)
                }
                return Color.clear
            }
        } else {
            EmptyView()
        }
    }

    var body: some View {
//        let path = makeSegmentPath(edge: edge, index: CGFloat(0))
        ZStack {
            ForEach(0..<model.segments) { index in
                let path = makeSegmentPath(edge: step, index: CGFloat(index))

                let isFilled = index < model.filledSegments
                path.fill(isFilled ? model.color : .gray).overlay(path.stroke(.white, lineWidth: 0.5))
            }
        }
        .overlay(geometryReader())
        //            .overlay(path.stroke(.black, lineWidth: 0.5))
//        .contentShape(path)
        .gesture(drag)
    }

    func makeSegmentPath(edge: CGFloat, index: CGFloat) -> Path {
        let smallRadius = edge * index
        let bigRadius = smallRadius + edge

        let startPoint = CGPoint(x: 0, y: smallRadius)
        let secondPoint = CGPoint(x: 0, y: bigRadius)
        let thirdPoint = calculatePoint(radius: smallRadius, radians: model.angle.radians)

        let startAngle = Angle(degrees: 90)
        let endAngle = Angle(degrees: startAngle.degrees - model.angle.degrees)

        let path = Path { path in
            path.move(to: startPoint)

            path.addLine(to: secondPoint)
            path.addArc(center: .zero, radius: bigRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: thirdPoint)
            path.addArc(center: .zero, radius: smallRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        }

        return path
    }
}

struct CircleSector_Previews: PreviewProvider {
    static let edge: CGFloat = 500

    static var previews: some View {
        CircleSector(model: .init(color: .yellow, angle: Angle(degrees: 30), segments: 10, filledSegments: 3))
    }
}
