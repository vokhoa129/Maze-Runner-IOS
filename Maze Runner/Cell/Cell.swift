//
//  Cell.swift
//  Maze Runner 2
//
//  Created by NGUYEN Tuan Anh on 20/01/2022.
//

import Foundation

class Cell: Identifiable, ObservableObject, Equatable, NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Cell(topWall: topWall, bottomWall: bottomWall, rightWall: rightWall, leftWall: leftWall, col: col, row: row)
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.col == rhs.col && lhs.row == rhs.row
    }
    
    var id = UUID()
    var topWall: Bool = true
    var bottomWall: Bool = true
    var rightWall: Bool = true
    var leftWall: Bool = true
    
    var col: Int
    var row: Int
    
    var visited = false
    
    var type: CellType?
    
    var isCurrent = false
    
    internal init(topWall: Bool = true, bottomWall: Bool = true, rightWall: Bool = true, leftWall: Bool = true, col: Int, row: Int, visited: Bool = false) {
        self.topWall = topWall
        self.bottomWall = bottomWall
        self.rightWall = rightWall
        self.leftWall = leftWall
        self.col = col
        self.row = row
        self.visited = visited
    }
    
    enum CellType {
        case start, end, path
    }
}
