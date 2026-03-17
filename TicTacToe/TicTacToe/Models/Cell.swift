//
//  Cell.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import Foundation

struct Cell: Identifiable {
    let id = UUID()
    var player: Player?
    
    // Sprawdza, czy pole jest jeszcze niezajęte
    var isEmpty: Bool {
        player == nil
    }
}
