//
//  GameBoardViewModel.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 21.11.21.
//

import Foundation

protocol GameBoardViewModelProtocol: AnyObject {
    func getToes() -> [String]
    func setToes(newToes: [String])
    func easyZeroPlayerMove(move: @escaping (_ etoes: [String]) -> ())
    func checkForWinner(toesOnBoard: [String], winner: @escaping (_ toe: String) -> () )
}


final class GameBoardViewModel: GameBoardViewModelProtocol {
    
    var toes = ["","","","","","","","",""] // ["X","O","X","O","O","O","X","X","X"]
    //var move: (() -> Void)?
    
    
    func getToes() -> [String] {
        toes
    }
    func setToes(newToes: [String]){
        toes = newToes
        print(toes)
    }
    
    func easyZeroPlayerMove(move: @escaping (_ etoes: [String]) -> ()){
        let countOfEmptySpaces = toes.filter{ $0 == "" }.count
        if countOfEmptySpaces <= 0 { return }
        var randomTurnPosition = Int.random(in: 1...countOfEmptySpaces)
        
        for (it , toe ) in  toes.enumerated() {
            if toe == "" {
                if randomTurnPosition == 1 {
                    toes[it] = "O"
                }
                randomTurnPosition -= 1
            }
        }
        
        move(toes)
    }
    
    func checkForWinner(toesOnBoard: [String], winner: @escaping (_ toe: String) -> () ){
        
        for it in stride(from: 0, to: 8, by: 3) {
            let secondP = it + 1
            let thirdP = it + 2
            if (
                toesOnBoard[it] ==  toesOnBoard[secondP] &&
                toesOnBoard[secondP] == toesOnBoard[thirdP]
            ){
                if toesOnBoard[it] != ""{
                winner(toesOnBoard[it])
                }
            }
            
        }
        
        for it in 0...2 {
            let secondP = it + 3
            let thirdP = secondP + 3
            if (
                toesOnBoard[it] ==  toesOnBoard[secondP] &&
                toesOnBoard[secondP] == toesOnBoard[thirdP]
            ){
                if toesOnBoard[it] != ""{
                winner(toesOnBoard[it])
                }
            }
            
        }
        
        
        do {
            let firstP = 2
            let secondP = firstP + 2
            let thirdP = secondP + 2
            if (
                toesOnBoard[firstP] ==  toesOnBoard[secondP] &&
                toesOnBoard[secondP] == toesOnBoard[thirdP]
            ){
                if toesOnBoard[firstP] != ""{
                winner(toesOnBoard[firstP])
                }
            }
        }
        
        do {
            if (
                toesOnBoard.first ==  toesOnBoard[4] &&
                toesOnBoard[4] == toesOnBoard.last
            ){
                if toesOnBoard[0] != ""{
                    winner(toesOnBoard[0])
                }
            }
        }
        
        do {
            if !toesOnBoard.contains("") {
                winner("Drow")
            }
        }
        
    }
    
    
}
