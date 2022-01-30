//
//  OnlineGameBoardViewModel.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 01.12.21.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase


protocol OnlineGameBoardViewModelProtocol: AnyObject{
    func getToes() -> [String]
    func getMyToe()-> String
    func setToes(newToes: [String])
    func atachOnlinePlayer(enemy:PlayerModel)
    func isPlayerTurn( turn: @escaping (_ gp: Bool, _ toe:String) -> ())
    func checkForWinner(toesOnBoard: [String], winner: @escaping (_ toe: String) -> () )
}

final class OnlineGameBoardViewModel: OnlineGameBoardViewModelProtocol {
    
    var toes = ["","","","","","","","",""] {
        didSet{
            
        }
    }
    
    
    var enemy: PlayerModel? = nil
    var gameSessionID = "null"
    var myToe = "O"
    let db = Database.database()
    let appUserUid = Auth.auth().currentUser?.uid ?? "null"
    var myRefGameSession: DatabaseReference?
    var myRefGameTurn: DatabaseReference?
    var myRefGameTurnPlayersToes: DatabaseReference?
    
    
    func getMyToe()->String{
        myToe
    }
    
    func getToes() -> [String] {
        toes
    }
    func setToes(newToes: [String]){
        
        if toes != newToes{
            toes = newToes
            print(toes)
            let onlineToes = toes.chunked(into: 3)
            self.myRefGameSession?.setValue(onlineToes)
        }
        
    }
    
    func isPlayerTurn( turn: @escaping (_ gp: Bool, _ toe:String) -> ()){
        
        if !toes.contains("X") && !toes.contains("O") {
            myRefGameTurn?.setValue(appUserUid)
            myToe = "X"
        }
        
        myRefGameTurn?.observeSingleEvent(of: .value, with: {[unowned self] snapshot in
            // Get user value
            let turnerUID = snapshot.value as? String
            
            if turnerUID == self.appUserUid {
                turn(true , self.myToe)
            }else {
                turn(false , self.myToe)
            }
            self.myRefGameTurn?.setValue(self.enemy?.uid ?? "nill")
            // ...
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    
    func atachOnlinePlayer(enemy:PlayerModel){
        self.enemy = enemy
        gameSessionID =  String("\(appUserUid)\(enemy.uid ?? "null")".sorted())
        myRefGameSession = db.reference(withPath:"Players_GameSessions/\(gameSessionID)")
        myRefGameTurn = db.reference(withPath:"Players_GameSessions_Turn/\(gameSessionID)")
        myRefGameTurnPlayersToes = db.reference(withPath:"Players_GameSessions_Turn_Players_Toes/\(gameSessionID)")
        
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


extension Array {
    
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
