//
//  BoardView.swift
//  TicTacToe
//
//  Created by Artur Żaczek on 19/03/2026.
//

import SwiftUI

// Komponent rysujący siatkę komórek
struct BoardView: View {
    @ObservedObject var viewModel: GameViewModel
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    private let boardSpacing: CGFloat = 15
    private let boardPadding: CGFloat = 15
    private let cellHeight: CGFloat = 100
    private let boardHeight: CGFloat = (3 * 100) + (2 * 15)
    
    @State private var winningLinePercentage: CGFloat = 0.0
    
    // Stan przechowujący przesunięcie planszy podczas gestu ciągnięcia
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color.gray.opacity(0.05)).cornerRadius(20)
            
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
                        WinningLineView(winningCombo: combo, size: geometry.size, boardSpacing: boardSpacing, cellHeight: cellHeight)
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
        // Aplikowanie fizycznego przesunięcia w osi Y
        .offset(y: dragOffset.height)
        
        // SPEŁNIENIE WYMOGU NR 5: Zaawansowana obsługa własnego gestu
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    // Pozwala ciągnąć planszę tylko w dół (wartości dodatnie)
                    if gesture.translation.height > 0 {
                        dragOffset = gesture.translation
                    }
                }
                .onEnded { gesture in
                    // Jeśli gracz przeciągnął planszę o więcej niż 100 pikseli w dół - resetuje rundę
                    if gesture.translation.height > 100 {
                        // Lekka wibracja (Haptic Feedback) przy resecie
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        withAnimation {
                            viewModel.resetRound()
                        }
                    }
                    
                    // Niezależnie od wyniku, plansza wraca na swoje miejsce z efektem sprężyny
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        dragOffset = .zero
                    }
                }
        )
        .onChange(of: viewModel.winningCombo) { _, newValue in
            if newValue == nil { winningLinePercentage = 0.0 }
        }
    }
}
