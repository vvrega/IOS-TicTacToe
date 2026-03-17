//
//  BoardView.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var viewModel: GameViewModel
    
    // Zmienne konfiguracyjne
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    private let boardSpacing: CGFloat = 15
    private let boardPadding: CGFloat = 15
    private let cellHeight: CGFloat = 100
    private let boardHeight: CGFloat = (3 * 100) + (2 * 15)
    
    @State private var winningLinePercentage: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            // Tło całej planszy
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.05))
                .cornerRadius(20)
            
            GeometryReader { geometry in
                ZStack {
                    LazyVGrid(columns: columns, spacing: boardSpacing) {
                        ForEach(0..<9, id: \.self) { index in
                            let isWinningCell = viewModel.winningCombo?.contains(index) ?? false
                            
                            CellView(cell: viewModel.cells[index], isWinning: isWinningCell) {
                                viewModel.makeMove(at: index)
                            }
                            .frame(height: cellHeight)
                        }
                    }
                    
                    if let combo = viewModel.winningCombo {
                        WinningLineView(
                            winningCombo: combo,
                            size: geometry.size,
                            boardSpacing: boardSpacing,
                            cellHeight: cellHeight
                        )
                        .trim(from: 0, to: winningLinePercentage)
                        .stroke(viewModel.currentPlayer == .x ? Color.blue : Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
                                winningLinePercentage = 1.0
                            }
                        }
                    }
                }
            }
            .frame(height: boardHeight)
            .padding(boardPadding)
        }
        .onChange(of: viewModel.winningCombo) { _, newValue in
            if newValue == nil {
                winningLinePercentage = 0.0
            }
        }
    }
}

struct WinningLineView: Shape {
    let winningCombo: [Int]
    let size: CGSize
    let boardSpacing: CGFloat
    let cellHeight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard winningCombo.count == 3 else { return path }
        
        let startCenter = centerPoint(for: winningCombo[0])
        let endCenter = centerPoint(for: winningCombo[2])
        
        let dx = endCenter.x - startCenter.x
        let dy = endCenter.y - startCenter.y
        
        let cellWidth = (size.width - (2 * boardSpacing)) / 3.0
        
        var scale: CGFloat = 0
        
        if dx != 0 && dy == 0 { // Linia pozioma
            scale = (cellWidth / 2.0) / abs(dx)
        } else if dx == 0 && dy != 0 { // Linia pionowa
            scale = (cellHeight / 2.0) / abs(dy)
        } else { // Przekątna
            let scaleX = (cellWidth / 2.0) / abs(dx)
            let scaleY = (cellHeight / 2.0) / abs(dy)
            scale = min(scaleX, scaleY)
        }
        
        // Rozciągamy punkty z obu stron za pomocą obliczonego skalera
        let p1 = CGPoint(x: startCenter.x - (dx * scale), y: startCenter.y - (dy * scale))
        let p2 = CGPoint(x: endCenter.x + (dx * scale), y: endCenter.y + (dy * scale))
        
        path.move(to: p1)
        path.addLine(to: p2)
        
        return path
    }
    
    private func centerPoint(for index: Int) -> CGPoint {
        let cellWidth = (size.width - (2 * boardSpacing)) / 3.0
        let row = CGFloat(index / 3)
        let col = CGFloat(index % 3)
        let x = col * (cellWidth + boardSpacing) + (cellWidth / 2.0)
        let y = row * (cellHeight + boardSpacing) + (cellHeight / 2.0)
        
        return CGPoint(x: x, y: y)
    }
}
