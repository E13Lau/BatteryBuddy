//
//  BatteryShape.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/3/24.
//

import SwiftUI

struct BatteryShape: View {
    var lowerBound: Double
    var upperBound: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 电池外壳
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .stroke(Color.gray, lineWidth: 3)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                // 电池正极
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray)
                    .frame(width: 16, height: geometry.size.height * 0.4)
                    .offset(x: geometry.size.width + 5, y: 0)

                // 电量显示
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .fill(Color.green)
                    .padding(5)
                    .frame(
                        width: CGFloat(upperBound - lowerBound) / 100 * geometry.size.width,
                        height: geometry.size.height
                    )
                    .offset(
                        x: CGFloat(lowerBound) / 100 * geometry.size.width, y: 0)
            }
        }
    }
}
