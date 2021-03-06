//
//  Pie.swift
//  Memorize
//
//  Created by yousef zuriqi on 01/10/2021.
//

import SwiftUI


struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startPoint = CGPoint(
            x: center.x + radius * CGFloat( cos(startAngle.radians)),
            y: center.y + radius * CGFloat( sin(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: startPoint)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        p.addLine(to: center)
        
        return p
        
    }
    
    
}
