//
//  AppScreen.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import Foundation

enum AppScreen: Equatable {
    case start
    case playing
    case matchOver(Player)
}
