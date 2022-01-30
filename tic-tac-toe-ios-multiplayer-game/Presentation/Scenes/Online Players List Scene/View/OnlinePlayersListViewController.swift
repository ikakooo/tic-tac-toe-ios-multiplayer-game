//
//  OnlinePlayersListViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 28.11.21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OnlinePlayersListViewController: UIViewController {
    @IBOutlet weak var onlinePlayersTableView: UITableView!
    @IBOutlet weak var niknameInputField: FloatingLabelInput!
    
    private var viewModel: OnlinePlayersListViewModelProtocol!
    private var dataService: OnlinePlayersListDataService!
    
        
//    let appUserUid = Auth.auth().currentUser?.uid
//    let appUserEmail = Auth.auth().currentUser?.email
//    let myNewRef = Database.database().reference(withPath:"Players/\(Auth.auth().currentUser?.uid ?? "error")")
//    let playersListRef = Database.database().reference(withPath:"Players")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .blue
        
        
        configureDataSource()
    }
    
    
    
    private func configureDataSource() {
        viewModel = OnlinePlayersListViewModel()
        dataService = OnlinePlayersListDataService(withController: self,
                                                   onlinePlayersTableView: onlinePlayersTableView,
                                                   niknameInputField: niknameInputField,
                                                   viewModel: viewModel)
        dataService.fetchCurrentUserName()
        dataService.refresh()
        
    }
    
    
    @IBAction func onLogautClick(_ sender: Any) {
        dataService.logOutPlayer()
    }
    
    @IBAction func onEditClick(_ sender: Any) {
        dataService.editPlayer()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataService.playerActiveStatus(isActive: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dataService.playerActiveStatus(isActive: false)
    }
    
}
