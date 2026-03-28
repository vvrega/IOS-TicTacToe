//
//  GameState.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import Foundation

// Określa aktualny stan trwającej rundy
enum GameState: Equatable {
    case playing
    case won(Player)
    case draw
    
    // Zwraca tekstowy komunikat odpowiedni do aktualnego stanu
    var message: String {
        switch self {
        case .playing: return "Gra Trwa"
        case .won(let player): return "Wygrywa Gracz \(player.rawValue)!"
        case .draw: return "Remis!"
        }
    }
}
