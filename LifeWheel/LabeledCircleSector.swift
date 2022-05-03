//
//  LabeledCircleSector.swift
//  SwiftUITest
//
//  Created by Юра Сорокин  on 01.05.2022.
//

import SwiftUI

extension LabeledCircleSector {
    struct Model {
        let circleModel: CircleSector.Model
        let text: String
        let isOut: Bool
        let fontSize: CGFloat
    }
}

struct LabeledCircleSector: View {
    let model: Model
    var spacing: CGFloat = 20

    @State private var textSize: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            let edge = min(geometry.size.width, geometry.size.height)
            let sectorEdge = edge - spacing - textSize.height
            let textEdge = edge - textSize.height
            let point = calculatePoint(radius: textEdge, radians: model.circleModel.angle.radians/2)

            ZStack(alignment: .topLeading) {
                CircleSector(model: model.circleModel)
                    .frame(width: sectorEdge, height: sectorEdge)

                let angleDegrees = (model.isOut ? 0 : 180) - model.circleModel.angle.degrees/2

                Text(model.text)
                    .readIntrinsicContentSize(to: $textSize)
                    .font(.system(size: model.fontSize))
                    .foregroundColor(.red)
                    .rotationEffect(.init(degrees: angleDegrees), anchor: .center)
                    .offset(x: point.x, y: point.y)
                    .offset(x: -textSize.width/2, y: 0)
            }
        }
    }
}

struct LabeledCircleSector_Previews: PreviewProvider {
    static var previews: some View {
        LabeledCircleSector(model: .init(
            circleModel: .init(color: .yellow, angle: .init(degrees: 90), segments: 10, filledSegments: 5),
            text: "Hello world",
            isOut: false,
            fontSize: 35
        )).previewLayout(.fixed(width: 500, height: 500))
    }
}
