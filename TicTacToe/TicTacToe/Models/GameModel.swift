//
//  GameModel.swift
//  TicTacToe
//
//  Created by Artur Żaczek on 11/04/2026.
//


import Foundation

struct GameModel {
    // Plansza składająca się z 9 pól
    var cells: [Cell] = Array(repeating: Cell(), count: 9)
    // Gracz, którego tura aktualnie trwa
    var currentPlayer: Player = .x
    // Stan obecnej rundy (trwa, wygrana, remis)
    var gameState: GameState = .playing
    // Tablica przechowująca 3 indeksy wygrywających pól (do rysowania linii)
    var winningCombo: [Int]? = nil
    
    // Docelowa liczba wygranych potrzebna do zakończenia meczu
    var targetWins: Int = 3
    // Aktualna liczba punktów gracza X
    var scoreX: Int = 0
    // Aktualna liczba punktów gracza O
    var scoreO: Int = 0
    
    // Zapamiętuje, kto rozpoczął obecną rundę (by zmieniać to co rundę)
    private var startingPlayer: Player = .x
    
    // Definicja wszystkich możliwych linii wygrywających (wiersze, kolumny, przekątne)
    private let winningCombinations: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]
    
    // Inicjuje całkowicie nowy mecz i resetuje punktację
    mutating func startMatch(target: Int) {
        targetWins = target
        scoreX = 0
        scoreO = 0
        startingPlayer = .x // Zawsze resetujemy do X przy nowym meczu
        currentPlayer = .x
        resetRound(changeStartingPlayer: false)
    }
    
    // Obsługa ruchu gracza i aktualizacja stanu gry
    mutating func makeMove(at index: Int) {
        // Blokuje ruch, jeśli pole jest zajęte lub runda się skończyła
        guard cells[index].isEmpty, gameState == .playing else { return }
        
        cells[index].player = currentPlayer
        
        // Sprawdza, czy obecny ruch zakończył rundę wygraną lub remisem
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
    private mutating func handleRoundWin(for player: Player) {
        if player == .x {
            scoreX += 1
        } else {
            scoreO += 1
        }
    }
    
    // Sprawdza, czy któryś z graczy osiągnął docelową liczbę wygranych i kończy mecz
    func checkMatchWinner() -> Player? {
        if scoreX >= targetWins {
            return .x
        } else if scoreO >= targetWins {
            return .o
        }
        return nil
    }
    
    // Sprawdza wszystkie możliwe kombinacje wygrywające dla danego gracza
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
    
    // Sprawdza, czy na planszy nie ma już wolnych pól (remis)
    private func checkDraw() -> Bool {
        !cells.contains(where: { $0.isEmpty })
    }
    
    // Czyści planszę i przygotowuje grę do kolejnej rundy
    mutating func resetRound(changeStartingPlayer: Bool = true) {
        cells = Array(repeating: Cell(), count: 9)
        if changeStartingPlayer {
            startingPlayer = startingPlayer.next
        }
        currentPlayer = startingPlayer
        gameState = .playing
        winningCombo = nil
    }
}
