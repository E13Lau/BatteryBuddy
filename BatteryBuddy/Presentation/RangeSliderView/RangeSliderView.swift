//
//  RangeSliderView.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 9/30/24.
//

import SwiftUI

struct RangeSliderView: View {
    @Binding var lowerBound: Double
    @Binding var upperBound: Double
    @Binding var isAvailable: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 电池形状的可视化范围
                BatteryShape(lowerBound: lowerBound, upperBound: upperBound)
                    .frame(width: geometry.size.width, height: 50)

                RangeSlider(lowerBound: $lowerBound, upperBound: $upperBound, isAvailable: $isAvailable)
                    .frame(width: geometry.size.width, height: 50)
            }
        }
    }
}

#Preview {
    struct PreviewView: View {
        
        @State var lower: Double = 10
        @State var upper: Double = 90
        @State var isAvailable: Bool = true

        var body: some View {
            RangeSliderView(lowerBound: $lower, upperBound: $upper, isAvailable: $isAvailable)
                .padding(40)
        }
    }
    
    return PreviewView()
}
