//
//  Cellview.swift
//  Maze Runner 2
//
//  Created by NGUYEN Tuan Anh on 20/01/2022.
//

import Foundation
import SwiftUI

struct CellView: Shape {
    var cell: Cell
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        path.move(to: .zero)
        if cell.topWall {
            path.addLine(to: topRight)
        } else {
            path.move(to: topRight)
        }
        
        if cell.rightWall {
            path.addLine(to: bottomRight)
        } else {
            path.move(to: bottomRight)
        }
        
        if cell.bottomWall {
            path.addLine(to: bottomLeft)
        } else {
            path.move(to: bottomLeft)
        }
        
        if cell.leftWall {
            path.addLine(to: .zero)
        } else {
            path.move(to: .zero)
        }
        
        return path
    }
}
