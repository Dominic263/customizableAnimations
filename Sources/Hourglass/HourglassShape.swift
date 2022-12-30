//
//  Hourglass.swift
//  Animations&Drawings
//  This view shows an animation of sand falling through an hourglass
//  Created by DOMINIC NDONDO on 12/29/22.
//
import SwiftUI
import Foundation
import PureSwiftUI

//define a grid, the layout guide here is defined in the PureSwiftUI package
let hourglassLayoutConfigGrid = LayoutGuideConfig.grid(columns: 30, rows: 30)

//define typeelias for the curves
private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

//
public struct HourglassShape: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //define a layout that you use to specify coordinates in the rect
        let g = hourglassLayoutConfigGrid.layout(in: rect)
        
        //define the points of interest/
        
        //First Line
        let p1 = g[7,0]
        let p2 = g[23,0]
        let control1_line1 = g[7,0]
        let control2_line1 = g[23,0]
        //First Curve
        let p3 = g[25, 3]
        let control1 = g[23, 0]
        let control2 = g[25, 0]
        
        //Second Curve
        let p4 = g[18,14]
        let control3 = g[24, 10]
        let control4 = g[18, 12]
       
        //Second line
        let l2 = g[18,16]
        let controll2 = g[18,14]
        let controll22 = g[18,16]
        
        // Third Curve
        let p5 = g[25, 27]
        let control5 = g[18,18]
        let control6 = g[24,20]
        
        
        //Forth Curve
        let p6 = g[23, 30]
        let control7 = g[25,30]
        let control8 = g[23, 30]
        
        //Third Line
        let l3 = g[7, 30]
        let controll3 = g[23,30]
        let controll33 = g[7,30]
        
        //Fifth Curve
        let p7 = g[ 5,27]
        let control9 = g[7,30]
        let control10 = g[5,30]
        
        //Fifth Curve
        let p8 = g[12,16]
        let control11 = g[6,20]
        let control12 = g[12,18]
        
        //Line 4
        let l4 = g[12, 14]
        let controll4 = g[12, 16]
        let controll44 = g[12, 14]
        
        
        //Sixth Curve
        let p9 = g[5,3]
        let control13 = g[12,12]
        let control14 = g[6,10]
        
        //Seventh Curve == to the first coordinate i.e p1
        let control15 = g[5,0]
        let control16 = g[7,0]
        
        //DRAWING
        
        path.move(to: p1)
        //First Line
        //path.line(p2)
        path.curve(p2, cp1: control1_line1, cp2: control2_line1, showControlPoints: false)
        
        path.curve(p3, cp1: control1, cp2: control2, showControlPoints: false)
        path.curve(p4, cp1: control3, cp2: control4, showControlPoints: false)
        
        //Second Line
        path.curve(l2, cp1: controll2, cp2: controll22, showControlPoints: false)
        
        
        path.curve(p5, cp1: control5, cp2: control6, showControlPoints: false)
        path.curve(p6, cp1: control7, cp2: control8, showControlPoints: false)
        
        //Third Line
        //path.line(l3)
        path.curve(l3, cp1: controll3, cp2: controll33, showControlPoints: false)
        path.curve(p7, cp1: control9, cp2: control10, showControlPoints: false)
        path.curve(p8, cp1: control11, cp2: control12, showControlPoints: false)
        
        //path.line(l4)
        path.curve(l4, cp1: controll4, cp2: controll44, showControlPoints: false)
        
        path.curve(p9, cp1: control13, cp2: control14, showControlPoints: false)
        
        path.curve(p1, cp1: control15, cp2: control16, showControlPoints: false)
       
        
        return path
    }
    public init () {}
}


struct HourglassView: View {
    var body: some View {
        VStack {
            HourglassShape()
                .stroke(Color.red, style: StrokeStyle.init(lineWidth: 1 , lineCap: .round , lineJoin: .round ))
                .frame(200)
            
            ZStack {
                Image(systemName: "hourglass.bottomhalf.filled")
                    .resizedToFit(200)
                    .foregroundColor(.gray)
                
                HourglassShape()
                    .stroke(Color.red, lineWidth: 2)
                    .layoutGuide(hourglassLayoutConfigGrid) //
                    .frame(200)
                
            }
            
        }
        
        
    }
}

struct HourglassView_Previews: PreviewProvider {
    static var previews: some View {
        HourglassView()
            .padding(50)
            .previewSizeThatFits()
            .previewDevice(.iPhone_13_Pro)
            .showLayoutGuides(true)
    }
}


