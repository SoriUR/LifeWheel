//
//  LifeWheelApp.swift
//  LifeWheel
//
//  Created by Юра Сорокин  on 03.05.2022.
//

import SwiftUI

@main
struct LifeWheelApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                let edge = geometry.size.width-20
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Chart(sectors: 8, segments: 10)
                            .frame(width: edge, height: edge)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .background(.white)
        }
    }
}

