//
//  BatteryView.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 11/4/24.
//

import SwiftUI

struct BatteryView: View {
    
    @Binding var progress: Double
    let fill: Color
    let outline: Color
    @State private var opacity = 0.0
    
    var body: some View {
        ZStack {
            Image(systemName: "battery.0")
                .resizable()
                .scaledToFit()
                .font(.headline.weight(.ultraLight))
                .foregroundStyle(outline)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(fill)
                        .scaleEffect(x: progress, y: 1, anchor: .leading)
                }
                .mask {
                    Image(systemName: "battery.100")
                        .resizable()
                        .scaledToFit()
                        .font(.headline.weight(.ultraLight))
                }
            
            Image(systemName: "bolt.fill")
                .resizable()
                .scaledToFit()
                .font(.title.weight(.ultraLight))
//                .background {
//                    Rectangle()
//                        .fill(fill)
//                    
//                }
//                .mask {
//                    Image(systemName: "bolt.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .font(.title3.weight(.ultraLight))
//                }
        }
    }
}

#Preview {
    @Previewable @State var value: Double = 0.05
    
    VStack {
        BatteryView(progress: $value, fill: .green, outline: .white)
        
        Slider(value: $value)
    }
    .padding()
}
