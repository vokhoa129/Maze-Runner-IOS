//
//  LineView.swift
//  Maze Runner
//
//  Created by NGUYEN Tuan Anh on 20/01/2022.
//

import SwiftUI

struct LineView: Shape {
    var cell: Cell
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        
        if !cell.topWall {
            path.move(to: center)
            path.addLine(to: top)
        }
        
        if !cell.bottomWall {
            path.move(to: center)
            path.addLine(to: bottom)
        }
        
        if !cell.rightWall {
            path.move(to: center)
            path.addLine(to: right)
        }
        
        if !cell.leftWall {
            path.move(to: center)
            path.addLine(to: left)
        }
        
        return path
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(cell: Cell(topWall: false, bottomWall: false, rightWall: true, leftWall: true, col: 2, row: 2))
            .stroke(lineWidth: 2)
            .foregroundColor(.primary)
            
    }
}
