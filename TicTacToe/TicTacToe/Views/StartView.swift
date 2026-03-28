//
//  StartView.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import SwiftUI

// Ekran startowy umożliwiający wybór liczby rund
struct StartView: View {
    @ObservedObject var viewModel: GameViewModel
    let predefinedOptions = [1, 3, 5, 10]
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Wybierz Ilość Wygranych Rund")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 15) {
                ForEach(predefinedOptions, id: \.self) { wins in
                    Button(action: {
                        withAnimation { viewModel.startMatch(target: wins) }
                    }) {
                        Text("\(wins)")
                            .font(.title2)
                            .bold()
                            .frame(width: 60, height: 60)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                }
            }
            
            VStack(spacing: 15) {
                Text("Lub Wpisz Własną Ilość:")
                    .font(.headline)
                
                HStack {
                    TextField("Np. 7", text: $viewModel.customTargetText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 100)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        if let customWins = Int(viewModel.customTargetText), customWins > 0 {
                            withAnimation { viewModel.startMatch(target: customWins) }
                        }
                    }) {
                        Text("Graj")
                            .bold()
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(Int(viewModel.customTargetText) == nil || Int(viewModel.customTargetText)! <= 0)
                }
            }
        }
    }
}
