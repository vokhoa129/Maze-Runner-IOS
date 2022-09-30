//
//  MazeView.swift
//  Maze Runner 2
//
//  Created by NGUYEN Tuan Anh on 20/01/2022.
//

import SwiftUI

struct MazeView: View {
    @StateObject var viewModel = MazeViewModel()
    var body: some View {
        VStack {
            Text("min path: \(viewModel.minPath)")
            Text("your move: \(viewModel.numberOfMove)")
            ScrollView([.horizontal, .vertical]) {
                ZStack {
                    maze
                    if viewModel.showHint {
                        path
                    }
                    
                }
            }
            HStack(alignment: .bottom) {
                Button(action: {
                    viewModel.createMaze()
                    viewModel.numberOfMove = 0
                }) {
                    Image(systemName: IconManager.icReload)
                        .font(.system(size: 40))
                }
                Spacer()
                
                dpad
                
                Spacer()
                
                Button {
                    viewModel.showHint.toggle()
                    
                } label: {
                    Image(systemName: viewModel.showHint ? IconManager.icUnHint : IconManager.icHint)
                        .font(.system(size: 40))
                }
            }
            .padding(.horizontal)
           
           
        }
        .onAppear {
            viewModel.createMaze()
        }
    }
}

extension MazeView {
    var maze: some View {
        LazyHGrid(rows: viewModel.gridCol, spacing: 0) {
            ForEach(viewModel.cells, id: \.id) {cell in
                ZStack {
                    CellView(cell: cell)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.primary)
                    if cell.isCurrent {
                        Color.green.opacity(0.8)
                            .clipShape(Circle())
                            .padding(viewModel.getCellSize() / 5)
                            .frame(width: viewModel.getCellSize(), height: viewModel.getCellSize())
                    }
                    if cell.type == .start {
                        Text("S")
                            .font(.system(size: 500))
                                    .minimumScaleFactor(0.01)
                            .frame(width: viewModel.getCellSize(), height: viewModel.getCellSize())
                    }
                    if cell.type == .end {
                        Text("E")
                            .font(.system(size: 500))
                                    .minimumScaleFactor(0.01)
                            .frame(width: viewModel.getCellSize(), height: viewModel.getCellSize())
                    }
                }
                .frame(width: viewModel.getCellSize(), height: viewModel.getCellSize())
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20,height: 600)
    }
    
    var path: some View {
        LazyHGrid(rows: viewModel.gridCol, spacing: 0) {
            ForEach(viewModel.cells, id: \.id) {cell in
                ZStack {
//                    Color.red.opacity(0.8)
//                        .hidden(cell.type == nil)
//                        .padding(.top, cell.topWall ? 2 : 0)
//                        .padding(.bottom, cell.bottomWall ? 2 : 0)
//                        .padding(.trailing, cell.rightWall ? 2 : 0)
//                        .padding(.leading, cell.leftWall ? 2 : 0)
                    
                    LineView(cell: cell)
                        .stroke(lineWidth: viewModel.getCellSize() / 4)
                        .foregroundColor(.red)
                        .hidden(cell.type == nil)
                }
                .frame(width: viewModel.getCellSize(), height: viewModel.getCellSize())
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20,height: 600)
    }
    
    var dpad: some View {
        VStack {
            Button {
                viewModel.up()
            } label: {
                Image(systemName: IconManager.icUp)
                    .resizable()
                    .frame(width: 60, height: 60)
            }
           

            HStack {
                Button {
                    viewModel.toLeft()
                } label: {
                    Image(systemName: IconManager.icLeft)
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                
                Button {
                    viewModel.down()
                } label: {
                    Image(systemName: IconManager.icDown)
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                
                Button {
                    viewModel.toRight()
                } label: {
                    Image(systemName: IconManager.icRight)
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }
        }
    }
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
}

//struct MazeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MazeView()
//            .environment(\.colorScheme, .dark)
//    }
//}
