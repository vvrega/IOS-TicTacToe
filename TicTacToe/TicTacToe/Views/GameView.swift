//
//  GameView.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        Group {
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
