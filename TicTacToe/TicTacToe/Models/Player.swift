//
//  Player.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import Foundation

// Reprezentuje gracza na planszy (Krzyżyk lub Kółko)
enum Player: String {
    case x = "X"
    case o = "O"
    
    // Zwraca gracza przeciwnego (służy do zmiany tury)
    var next: Player {
        self == .x ? .o : .x
    }
}

