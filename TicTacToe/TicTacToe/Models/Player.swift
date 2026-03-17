//
//  Player.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import Foundation

enum Player: String {
    case x = "X"
    case o = "O"
    
    // Zwraca przeciwnika
    var next: Player {
        self == .x ? .o : .x
    }
}

