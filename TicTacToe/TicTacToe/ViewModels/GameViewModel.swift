//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Artur Żaczek on 19/03/2026.
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var cells: [Cell] = Array(repeating: Cell(), count: 9)
    @Published var currentPlayer: Player = .x
    @Published var gameState: GameState = .playing
    @Published var winningCombo: [Int]? = nil
    
    // Zmienne zarządzające całym meczem
    @Published var appScreen: AppScreen = .start
    @Published var targetWins: Int = 3
    @Published var customTargetText: String = ""
    @Published var scoreX: Int = 0
    @Published var scoreO: Int = 0
    
    private var startingPlayer: Player = .x
    
    private let winningCombinations: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]
    
    // Rozpoczęcie nowego meczu
    func startMatch(target: Int) {
        targetWins = target
        scoreX = 0
        scoreO = 0
        startingPlayer = .x // Zawsze resetujemy do X przy nowym meczu
        currentPlayer = .x
        appScreen = .playing
        resetRound(changeStartingPlayer: false)
    }
    
    func makeMove(at index: Int) {
        guard cells[index].isEmpty, gameState == .playing else { return }
        
        cells[index].player = currentPlayer
        
        if let combo = checkWin(for: currentPlayer) {
            winningCombo = combo
            gameState = .won(currentPlayer)
            handleRoundWin(for: currentPlayer)
        } else if checkDraw() {
            gameState = .draw
        } else {
            currentPlayer = currentPlayer.next
        }
    }
    
    // Aktualizacja punktów i sprawdzanie wygranej meczu
    private func handleRoundWin(for player: Player) {
        if player == .x {
            scoreX += 1
        } else {
            scoreO += 1
        }
        
        if scoreX >= targetWins {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.appScreen = .matchOver(.x)
            }
        } else if scoreO >= targetWins {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.appScreen = .matchOver(.o)
            }
        }
    }
    
    private func checkWin(for player: Player) -> [Int]? {
        for combo in winningCombinations {
            if cells[combo[0]].player == player &&
               cells[combo[1]].player == player &&
               cells[combo[2]].player == player {
                return combo
            }
        }
        return nil
    }
    
    private func checkDraw() -> Bool {
        !cells.contains(where: { $0.isEmpty })
    }
    
    // Resetowanie pojedynczej rundy
    func resetRound(changeStartingPlayer: Bool = true) {
        cells = Array(repeating: Cell(), count: 9)
        if changeStartingPlayer {
            startingPlayer = startingPlayer.next
        }
        currentPlayer = startingPlayer
        gameState = .playing
        winningCombo = nil
    }
    
    // Powrót do menu głównego
    func quitMatch() {
        appScreen = .start
    }
}
