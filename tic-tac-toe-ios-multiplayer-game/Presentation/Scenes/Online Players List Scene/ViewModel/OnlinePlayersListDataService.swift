//
//  OnlinePlayersListDataService.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 30.11.21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OnlinePlayersListDataService: NSObject, UITableViewDataSource, UITableViewDelegate  {
    
    private var controller: UIViewController!
    private var onlinePlayersTableView: UITableView!
    private var niknameInputField: FloatingLabelInput!
    private var viewModel: OnlinePlayersListViewModelProtocol!
    
    private var gamePlayers:[PlayerModel] = [] {
        didSet{
            onlinePlayersTableView.reloadData()
        }
    }
    
    let appUserUid = Auth.auth().currentUser?.uid
    let appUserEmail = Auth.auth().currentUser?.email
    let myNewRef = Database.database().reference(withPath:"Players/\(Auth.auth().currentUser?.uid ?? "error")")
    //    let playersListRef = Database.database().reference(withPath:"Players")
    
    init(withController: UIViewController,
         onlinePlayersTableView: UITableView,
         niknameInputField: FloatingLabelInput!,
         viewModel: OnlinePlayersListViewModelProtocol)
    {
        super.init()
        self.controller = withController
        self.onlinePlayersTableView = onlinePlayersTableView
        self.niknameInputField = niknameInputField
        self.onlinePlayersTableView.dataSource = self
        self.onlinePlayersTableView.delegate = self
        self.onlinePlayersTableView.registerNib(class: OnlineStatusCell.self)
        self.viewModel = viewModel
    }
    
    func refresh(){
        viewModel.getUsersList(){ Players in
            self.gamePlayers = Players
        }
    }
    
    
    func editPlayer(){
        myNewRef.setValue(["uid": appUserUid ?? "",
                           "Email": appUserEmail ?? "",
                           "name": niknameInputField.text ?? "",
                           "activeStatus": true])
    }
    
    func logOutPlayer() {
        UDManager.markUserAsLoggedOut()
        do {
            try Auth.auth().signOut()
            self.controller.navigationController?.popToRootViewController(animated: true)
        } catch let error {
            print("Auth sign out failed: \(error)")
        }
    }
    
    func  fetchCurrentUserName(){
        myNewRef.observe(.value) {[weak self] snapshot in
            if snapshot.exists() {
                let value =   snapshot.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                
                self?.niknameInputField.text = name
            } else {
                // self.onlineUserCount.title = "0"
            }
        }
    }
    
    
    func playerActiveStatus(isActive: Bool) {
        let myNewRef = Database.database().reference(withPath:"Players/\(appUserUid ?? "error")/activeStatus")
        myNewRef.setValue(isActive)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gamePlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(OnlineStatusCell.self, for: indexPath)
        cell.configure(with: gamePlayers[indexPath.row])
        return cell
    }
    
    // Cell click listener
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "OnlineGameBoardViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "OnlineGameBoardViewController") as? OnlineGameBoardViewController else {return}
        
        vc.playerEnemy = { [ weak self] in  return self?.gamePlayers[indexPath.row]}
        
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
}
