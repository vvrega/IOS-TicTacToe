//
//  Cell.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import Foundation

// Model reprezentujący pojedyncze pole na planszy
struct Cell: Identifiable {
    let id = UUID()
    var player: Player?
    
    // Sprawdza, czy dane pole nie zostało jeszcze zajęte
    var isEmpty: Bool {
        player == nil
    }
}
