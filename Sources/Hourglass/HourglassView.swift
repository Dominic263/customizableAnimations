//
//  HourglassView.swift
//  Animations&Drawings
//  This view creates an hourglass and animates the soil movement due to gravity
//  Created by DOMINIC NDONDO on 12/30/22.
//
import PureSwiftUI
import SwiftUI

public struct Hourglass: View {
    //parameters to control the hourglass
    let hourglassSize: CGFloat
    let glassColor: Color
    let sandColor: Color
    let animationTime: Double
    
    //These offsets will help to control the sand animations
    @State private var topOffset: CGFloat = 0
    @State private var bottomOffset: CGFloat = 0
    @State private var middleOffset: CGFloat = 0
    
    
    public init(
        hourglassSize: CGFloat,
        glassColor: Color,
        sandColor: Color,
        animationTime: Double
    ) {
        self.hourglassSize = hourglassSize
        self.glassColor = glassColor
        self.sandColor = sandColor
        self.animationTime = animationTime
    }
    
    public var body: some View {
        ZStack {
            ZStack {
                //frames are abritrarily shosen based on look
                Rectangle()
                    .frame(width: hourglassSize, height: hourglassSize/2)
                    .foregroundColor(sandColor)
                    .offset(y: topOffset)
                
                 .mask (
                 Rectangle()
                    .frame(width: hourglassSize, height: hourglassSize/2)
                 )
                .offset(y: -hourglassSize/4 - hourglassSize * 0.03)
                
                Rectangle()
                    .frame(width: hourglassSize * 0.07 , height: hourglassSize / 2)
                    .foregroundColor(sandColor)
                    .offset(y: middleOffset)
                
                Rectangle()
                    .frame(width: hourglassSize, height: hourglassSize / 2)
                    .foregroundColor(sandColor)
                    .offset(y: bottomOffset)
                // to check what the effect of mask really is
                 .mask(
                    Rectangle()
                        .frame(width: hourglassSize, height: hourglassSize / 2)
                 )
                 .offset(y: hourglassSize / 4 + hourglassSize * 0.03)
            }
            .mask(
                HourglassShape()
                    .frame(width: hourglassSize * 0.8, height: hourglassSize)
            )
            
            //This gives us the shape of the hourglass
            HourglassShape()
                    .stroke(glassColor, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .frame(width: hourglassSize * 0.8 , height: hourglassSize)
            
        }
        .onAppear{
            //Sand should always start at the top
            bottomOffset = hourglassSize / 2
            middleOffset = -hourglassSize/4 - hourglassSize * 0.03
        }
        .onTapGesture(
            count: 1,
            perform: {
                startAnimation(time: animationTime)
            /*
                Timer.scheduledTimer(
                    withTimeInterval: 5.0,
                    repeats: true) { _ in
                        startAnimation()
                    }
            */
            }
        )
        
    }
    
    //This function is placed inside the view but this is bad
    private func startAnimation(time: Double) {
    withAnimation(Animation.linear(duration: time*0.15)) {
    middleOffset = (hourglassSize / 4) - hourglassSize * 0.03
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + time*0.95) {
        withAnimation(Animation.linear(duration: time*0.25)) {
            middleOffset += (hourglassSize / 4)
        }
    }
    withAnimation(Animation.linear(duration: time*1)) {
        topOffset = hourglassSize / 2
    }
    
        withAnimation(Animation.linear(duration: time*1).delay(time*0.1)) {
        bottomOffset = 0
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + time*1.0) {

            topOffset = 0
            bottomOffset = hourglassSize / 2
            middleOffset = -hourglassSize / 4 - hourglassSize * 0.03
        }
    }
}




struct Hourglass_Previews: PreviewProvider {
    static var previews: some View {
        Hourglass(hourglassSize: 200, glassColor: .gray, sandColor: .yellow, animationTime: 4)
    }
}
