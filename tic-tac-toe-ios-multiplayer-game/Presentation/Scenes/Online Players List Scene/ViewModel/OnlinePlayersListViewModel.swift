//
//  OnlinePlayersListViewModel.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 30.11.21.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase


protocol OnlinePlayersListViewModelProtocol:AnyObject{
    func getUsersList(gamePlayers: @escaping (_ players: [PlayerModel]) -> ())
}

class OnlinePlayersListViewModel: OnlinePlayersListViewModelProtocol {
    
    var activePlayersList:[PlayerModel] = []
    var nonActivePlayersList:[PlayerModel] = []
    
    let appUserUid = Auth.auth().currentUser?.uid
    let playersListRef = Database.database().reference(withPath:"Players")
    
    func getUsersList(gamePlayers: @escaping (_ sortedPlayers: [PlayerModel]) -> ()){
        playersListRef.observe(DataEventType.value, with: { [weak self] snapshot in
            
            if snapshot.exists() {
                self?.activePlayersList.removeAll()
                self?.nonActivePlayersList.removeAll()
                
                let value =   snapshot.value as? NSDictionary
                // print(value)
                
                value?.forEach{ pl in
                    let player = pl.value as? NSDictionary
                    
                    let activeStatus = player?["activeStatus"] as? Bool ?? false
                    let email = player?["email"] as? String ?? ""
                    let name = player?["name"] as? String ?? ""
                    let uid = player?["uid"] as? String ?? ""
                    
                    
                    if uid != self?.appUserUid {
                        
                        if (activeStatus == true) {
                            self?.activePlayersList.append(PlayerModel(uid: uid,
                                                                       Email: email,
                                                                       name: name,
                                                                       activeStatus: activeStatus))
                        }else {
                            self?.nonActivePlayersList.append(PlayerModel(uid: uid,
                                                                          Email: email,
                                                                          name: name,
                                                                          activeStatus: activeStatus))
                        }
                    }
                }
                gamePlayers( (self?.activePlayersList ?? []) + (self?.nonActivePlayersList  ?? []) )
            } else {
                gamePlayers([])
            }
        })
    }
    
    
    
}
