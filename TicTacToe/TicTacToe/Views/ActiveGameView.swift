//
//  ActiveGameView.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import SwiftUI

struct ActiveGameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Tablica wyników
            VStack(spacing: 10) {
                Text("Gra Do \(viewModel.targetWins) Wygranych")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 40) {
                    VStack {
                        Text("Gracz X")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text("\(viewModel.scoreX)")
                            .font(.system(size: 40, weight: .bold))
                    }
                    
                    Text(":")
                        .font(.largeTitle)
                        .bold()
                    
                    VStack {
                        Text("Gracz O")
                            .font(.headline)
                            .foregroundColor(.red)
                        Text("\(viewModel.scoreO)")
                            .font(.system(size: 40, weight: .bold))
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)
            }
            .padding(.top, 20)
            
            // Informacja o turze i wyniku rundy
            VStack {
                if viewModel.gameState == .playing {
                    Text("Tura Gracza: \(viewModel.currentPlayer.rawValue)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(viewModel.currentPlayer == .x ? .blue : .red)
                } else {
                    Text(viewModel.gameState.message)
                        .font(.title)
                        .bold()
                        .foregroundColor(.green)
                }
            }
            .frame(height: 50)
            
            BoardView(viewModel: viewModel)
                .padding(.horizontal)
            
            Spacer()
            
            // Przyciski akcji
            VStack(spacing: 15) {
                if viewModel.gameState != .playing && viewModel.scoreX < viewModel.targetWins && viewModel.scoreO < viewModel.targetWins {
                    Button(action: {
                        withAnimation { viewModel.resetRound() }
                    }) {
                        Text("Następna Runda")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.indigo)
                            .cornerRadius(15)
                    }
                }
                
                Button(action: {
                    withAnimation { viewModel.quitMatch() }
                }) {
                    Text("Zakończ Mecz I Wróć Do Menu")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
    }
}
