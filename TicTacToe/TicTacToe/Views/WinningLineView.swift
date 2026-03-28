//
//  WinningLineView.swift
//  TicTacToe
//
//  Created by Artur Żaczek on 19/03/2026.
//

import SwiftUI

// Model wektorowy (Shape) wyliczający idealne współrzędne dla wygrywającej linii
struct WinningLineView: Shape {
    let winningCombo: [Int]
    let size: CGSize
    let boardSpacing: CGFloat
    let cellHeight: CGFloat
    
    // Główna funkcja Shape rysująca ścieżkę z punktu A do punktu B
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard winningCombo.count == 3 else { return path }
        
        let startCenter = centerPoint(for: winningCombo[0])
        let endCenter = centerPoint(for: winningCombo[2])
        
        // Oblicza wektor kierunkowy, by wydłużyć linię z zachowaniem idealnego kąta
        let dx = endCenter.x - startCenter.x
        let dy = endCenter.y - startCenter.y
        let cellWidth = (size.width - (2 * boardSpacing)) / 3.0
        
        // Dynamicznie dobiera skalę wydłużenia w zależności od kierunku (pion/poziom/przekątna)
        var scale: CGFloat = 0
        if dx != 0 && dy == 0 { // Linia pozioma
            scale = (cellWidth / 2.0) / abs(dx)
        } else if dx == 0 && dy != 0 { // Linia pionowa
            scale = (cellHeight / 2.0) / abs(dy)
        } else { // Przekątna
            let scaleX = (cellWidth / 2.0) / abs(dx)
            let scaleY = (cellHeight / 2.0) / abs(dy)
            scale = min(scaleX, scaleY)
        }
        
        // Rozciągamy punkty z obu stron za pomocą obliczonego skalera
        let p1 = CGPoint(x: startCenter.x - (dx * scale), y: startCenter.y - (dy * scale))
        let p2 = CGPoint(x: endCenter.x + (dx * scale), y: endCenter.y + (dy * scale))
        
        path.move(to: p1)
        path.addLine(to: p2)
        
        return path
    }
    
    // Oblicza dokładny środek geometryczny dla konkretnego pola na siatce
    private func centerPoint(for index: Int) -> CGPoint {
        let cellWidth = (size.width - (2 * boardSpacing)) / 3.0
        let row = CGFloat(index / 3)
        let col = CGFloat(index % 3)
        let x = col * (cellWidth + boardSpacing) + (cellWidth / 2.0)
        let y = row * (cellHeight + boardSpacing) + (cellHeight / 2.0)
        
        return CGPoint(x: x, y: y)
    }
}
