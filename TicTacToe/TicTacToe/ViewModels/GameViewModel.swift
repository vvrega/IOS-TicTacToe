//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Artur Żaczek on 19/03/2026.
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    // Instancja czystego modelu przetrzymująca stan i logikę
    @Published private var gameModel = GameModel()
    // Zmienna kontrolująca aktywny ekran (menu, gra, podsumowanie)
    @Published var appScreen: AppScreen = .start
    // Tekst wpisywany przez użytkownika dla własnej liczby rund
    @Published var customTargetText: String = ""
    // Plansza składająca się z 9 pól
    var cells: [Cell] { gameModel.cells }
    // Gracz, którego tura aktualnie trwa
    var currentPlayer: Player { gameModel.currentPlayer }
    // Stan obecnej rundy (trwa, wygrana, remis)
    var gameState: GameState { gameModel.gameState }
    // Tablica przechowująca 3 indeksy wygrywających pól (do rysowania linii)
    var winningCombo: [Int]? { gameModel.winningCombo }
    // Docelowa liczba wygranych potrzebna do zakończenia meczu
    var targetWins: Int { gameModel.targetWins }
    // Aktualna liczba punktów gracza X
    var scoreX: Int { gameModel.scoreX }
    // Aktualna liczba punktów gracza O
    var scoreO: Int { gameModel.scoreO }
    
    
    // --- PRZEKAZYWANIE AKCJI DO MODELU I ZARZĄDZANIE EKRANEM ---
    
    // Inicjuje całkowicie nowy mecz i resetuje punktację
    func startMatch(target: Int) {
        gameModel.startMatch(target: target)
        appScreen = .playing
    }
    
    // Obsługa ruchu gracza i aktualizacja stanu gry
    func makeMove(at index: Int) {
        // Przekazanie wykonania ruchu do Modelu
        gameModel.makeMove(at: index)
        
        // Sprawdza, czy któryś z graczy osiągnął docelową liczbę wygranych i kończy mecz
        if let winner = gameModel.checkMatchWinner() {
            // Opóźnienie zarządzane w ViewModelu, ponieważ to akcja związana z interfejsem (UI)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.appScreen = .matchOver(winner)
            }
        }
    }
    
    // Czyści planszę i przygotowuje grę do kolejnej rundy
    func resetRound(changeStartingPlayer: Bool = true) {
        gameModel.resetRound(changeStartingPlayer: changeStartingPlayer)
    }
    
    // Powrót do menu głównego
    func quitMatch() {
        appScreen = .start
    }
}
