//
//  CellView.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import SwiftUI

struct CellView: View {
    var cell: Cell
    var isWinning: Bool
    var action: () -> Void
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Zmiana koloru tła w zależności od tego, czy komórka wygrywa
            Rectangle()
                .foregroundColor(isWinning ? Color.green.opacity(0.4) : Color.blue.opacity(0.1))
                .cornerRadius(15)
                .animation(.easeInOut(duration: 0.3), value: isWinning)
            
            if let player = cell.player {
                Text(player.rawValue)
                    .font(.system(size: 65, weight: .heavy, design: .rounded))
                    .foregroundColor(player == .x ? .blue : .red)
                    .scaleEffect(isAnimating ? 1.0 : 0.001)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    .onAppear {
                        // Animacja pojawiania się znaku
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            isAnimating = true
                        }
                    }
            }
        }
        .onTapGesture {
            action()
        }
    }
}
