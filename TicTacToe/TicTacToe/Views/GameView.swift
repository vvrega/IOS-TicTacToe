//
//  GameView.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import SwiftUI

// Widok "Router" - decyduje, który z trzech ekranów pokazać użytkownikowi
struct GameView: View {
    // Tworzy i przechowuje instancję ViewModelu dla całej aplikacji
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        Group {
            // Przełącza ekrany w zależności od stanu w ViewModelu
            switch viewModel.appScreen {
            case .start:
                StartView(viewModel: viewModel)
            case .playing:
                ActiveGameView(viewModel: viewModel)
            case .matchOver(let winner):
                VictoryView(winner: winner, viewModel: viewModel)
            }
        }
        .animation(.easeInOut, value: viewModel.appScreen) // Płynne przejścia między ekranami
    }
}

//#Preview {
//    GameView()
//}
