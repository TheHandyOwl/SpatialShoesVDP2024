//
//  RoundedCorner.swift
//  SpatialShoesVDP2024
//
//  Created by Carlos Company on 15/9/24.
//

import SwiftUI

//struct RoundedCorner: Shape {
//
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//    
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let topLeft = corners.contains(.topLeft) ? radius : 0
        let topRight = corners.contains(.topRight) ? radius : 0
        let bottomLeft = corners.contains(.bottomLeft) ? radius : 0
        let bottomRight = corners.contains(.bottomRight) ? radius : 0
        
        path.move(to: CGPoint(x: rect.minX + topLeft, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        
        if topRight > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - topRight, y: rect.minY + topRight),
                        radius: topRight,
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 0),
                        clockwise: false)
        }
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        
        if bottomRight > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY - bottomRight),
                        radius: bottomRight,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
        }
        
        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        
        if bottomLeft > 0 {
            path.addArc(center: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY - bottomLeft),
                        radius: bottomLeft,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 180),
                        clockwise: false)
        }
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        
        if topLeft > 0 {
            path.addArc(center: CGPoint(x: rect.minX + topLeft, y: rect.minY + topLeft),
                        radius: topLeft,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 270),
                        clockwise: false)
        }
        
        return path
    }
}
