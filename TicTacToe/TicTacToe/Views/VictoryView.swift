//
//  VictoryView.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import SwiftUI

struct VictoryView: View {
    var winner: Player
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Mecz Zakończony!")
                .font(.largeTitle)
                .fontWeight(.black)
            
            Text("Wygrywa Gracz \(winner.rawValue)")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(winner == .x ? .blue : .red)
                .padding()
                .background(winner == .x ? Color.blue.opacity(0.2) : Color.red.opacity(0.2))
                .cornerRadius(20)
            
            Button(action: {
                withAnimation { viewModel.quitMatch() }
            }) {
                Text("Zagraj Ponownie")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 250)
                    .background(Color.green)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.top, 40)
        }
    }
}
