//
//  AppScreen.swift
//  TicTacToe
//
//  Created by Marcin Wręga on 17/03/2026.
//

import Foundation

// Definiuje, który z głównych ekranów aplikacji ma być teraz widoczny
enum AppScreen: Equatable {
    case start
    case playing
    case matchOver(Player)
}
