//
//  test.swift
//  SwiftUITest
//
//  Created by Юра Сорокин  on 01.05.2022.
//

import CoreGraphics

func calculatePoint(radius: CGFloat, radians: CGFloat) -> CGPoint {
    CGPoint(x: radius * sin(radians), y: radius * cos(radians))
}

func calculateX(radius: CGFloat, radians: CGFloat) -> CGFloat {
    radius * tan(radians)
}

func calculateRadius(point: CGPoint) -> CGFloat {
    sqrt(point.x * point.x + point.y * point.y)
}
