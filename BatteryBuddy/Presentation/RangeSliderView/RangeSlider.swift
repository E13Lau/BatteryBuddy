//
//  RangeSlider.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/3/24.
//

import SwiftUI

struct RangeSlider: View {
    @Binding var lowerBound: Double
    @Binding var upperBound: Double
    @Binding var isAvailable: Bool

    /// 最小距离
    private let minSpace: CGFloat = 20

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.clear)

                buildLower(geometry: geometry)
                buildUpper(geometry: geometry)
            }
        }
    }
    
    @ViewBuilder
    func buildLower(geometry: GeometryProxy) -> some View {
        Circle()
            .fill(Color.white)
            .overlay {
                Image(
                    systemName:
                        "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right"
                )
                .foregroundStyle(isAvailable ? Color.accentColor : Color.gray)
            }
            .frame(width: 30, height: 30)
            .shadow(radius: 4)
            .offset(x: (CGFloat(lowerBound) / 100 * geometry.size.width) - 15)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newValue = Double(
                            value.location.x / geometry.size.width * 100)
                        lowerBound = min(max(0, newValue), upperBound - minSpace)
                    },
                isEnabled: isAvailable
            )
    }
    
    @ViewBuilder
    func buildUpper(geometry: GeometryProxy) -> some View {
        Circle()
            .fill(Color.white)
            .overlay {
                Image(
                    systemName:
                        "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right"
                )
                .foregroundStyle(isAvailable ? Color.accentColor : Color.gray)
            }
            .frame(width: 30, height: 30)
            .shadow(radius: 4)
            .offset(x: CGFloat(upperBound) / 100 * geometry.size.width - 15)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newValue = Double(
                            value.location.x / geometry.size.width * 100)
                        upperBound = max(min(100, newValue), lowerBound + minSpace)
                    },
                isEnabled: isAvailable
            )
    }
}
