//
//  MyObjservableOject.swift
//  Maze Runner 2
//
//  Created by NGUYEN Tuan Anh on 20/01/2022.
//

import Foundation
import SwiftUI

class MyObjservableOject: ObservableObject {
    let COLS = 30
    let ROWS = 30
    var gridCol: [GridItem] {
        return [GridItem].init(repeating: GridItem(.fixed(getCellSize()), spacing: 0), count: ROWS)
    }
    @Published var cells = [Cell]()
    @Published var showHint = false
    @Published var current = Cell(col: 0, row: 0)
    
    @Published var numberOfMove = 0
    var minPath: Int {
        return cells.filter { cell in
            cell.type == .path
        }.count + 1
    }
}

extension MyObjservableOject {
    
    func createMaze() -> Void {
        //initial cells
        let colItem = [Cell].init(repeating: Cell(col: 0, row: 0), count: ROWS)
        var cells = [[Cell]].init(repeating: colItem, count: COLS)
        
        let startCol = Int.random(in: 0..<COLS)
        let startRow = Int.random(in: 0..<ROWS)
        let endCol = Int.random(in: 0..<COLS)
        let endRow = Int.random(in: 0..<ROWS)
        
        for col in 0..<COLS {
            for row in 0..<ROWS {
                cells[col][row] = Cell(col: col, row: row)
            }
        }
        
        //initial maze
        var current = cells[startCol][startRow]
        current.type = .start
        current.visited = true
        current.isCurrent = true
        
        var stack = [Cell]()
        var toEnd = false
        
        repeat {
            let next = getNeighbour(of: current, in: cells)
            if let next = next {
                removeWall(current: current, next: next)
                stack.append(current)
                
                current = next
                current.visited = true
                if current.row == endRow && current.col == endCol {
                    current.type = .end
                    toEnd = true
                }
                if !toEnd {
                    current.type = .path
                }
             
            } else {
                if !toEnd {
                    current.type = nil
                }
                current = stack.last!
                stack.removeLast()
            }
        } while !stack.isEmpty
        
        self.current = cells[startCol][startRow].copy() as! Cell
        
        self.cells = Array(cells.joined())
    }
    
    private func getNeighbour(of cell: Cell, in allCells: [[Cell]]) -> Cell? {
        var neighbours = [Cell]()
        
        //top neighbour
        if cell.row > 0 && !allCells[cell.col][cell.row - 1].visited {
            neighbours.append(allCells[cell.col][cell.row - 1])
        }
        
        //bottom neighbour
        if cell.row < ROWS - 1 && !allCells[cell.col][cell.row + 1].visited {
            neighbours.append(allCells[cell.col][cell.row + 1])
        }
        
        //left neighbour
        if cell.col > 0 && !allCells[cell.col - 1][cell.row].visited {
            neighbours.append(allCells[cell.col - 1][cell.row])
        }
        
        //right neighbour
        if cell.col < COLS - 1 && !allCells[cell.col + 1][cell.row].visited {
            neighbours.append(allCells[cell.col + 1][cell.row])
        }
        
        if neighbours.isEmpty {
            return nil
        } else {
            return neighbours[Int.random(in: 0..<neighbours.count)]
        }
    }
    
    private func removeWall(current: Cell, next: Cell) -> Void {
        if current.col == next.col && current.row == next.row - 1 {
            current.bottomWall = false
            next.topWall = false
        }
        
        if current.col == next.col && current.row == next.row + 1 {
            current.topWall = false
            next.bottomWall = false
        }
        
        if current.col == next.col - 1 && current.row == next.row {
            current.rightWall = false
            next.leftWall = false
        }
        
        if current.col == next.col + 1 && current.row == next.row {
            current.leftWall = false
            next.rightWall = false
        }
    }
    
    func getCellSize() -> CGFloat {
        let width = UIScreen.main.bounds.width - 40
        let height: CGFloat = 600 //UIScreen.main.bounds.height - 200
        var cellSize: CGFloat
        if width / height < CGFloat(COLS / ROWS) {
            cellSize = width / CGFloat(COLS + 1)
        } else {
            cellSize = height / CGFloat(ROWS + 1)
        }
        
        if cellSize > 10 {return cellSize}
        else {return 10}
    }
    
    //-MARK: move
    
    func up() -> Void {
        if !current.topWall {
            let nextCell = Cell(col: current.col, row: current.row - 1)
            move(from: current, to: nextCell)
        }
    }
    
    func down() -> Void {
        if !current.bottomWall {
            let nextCell = Cell(col: current.col, row: current.row + 1)
            move(from: current, to: nextCell)
        }
    }
    
    func toRight() -> Void {
        if !current.rightWall {
            let nextCell = Cell(col: current.col + 1, row: current.row)
            move(from: current, to: nextCell)
        }
    }
    
    func toLeft() -> Void {
        if !current.leftWall {
            let nextCell = Cell(col: current.col - 1, row: current.row)
            move(from: current, to: nextCell)
        }
    }
    
    
    private func move(from current: Cell, to next: Cell) -> Void {
        
        numberOfMove = numberOfMove + 1
        
        cells.first {$0 == current}?.isCurrent = false
        
        let nextCell = cells.first{$0 == next}!
        nextCell.isCurrent = true
        
        self.current = nextCell.copy() as! Cell
    }
}


