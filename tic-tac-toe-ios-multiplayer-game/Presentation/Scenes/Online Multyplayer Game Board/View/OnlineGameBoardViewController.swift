//
//  OnlineGameBoardViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 01.12.21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OnlineGameBoardViewController: UIViewController {
    @IBOutlet private weak var CollectionViewGamePlay: UICollectionView!
    @IBOutlet private weak var onlinePlayerProfile: RoundedImageView!
    @IBOutlet private weak var onlinePlayerName: UILabel!
    @IBOutlet private weak var appUserProfile: RoundedImageView!
    @IBOutlet private weak var onlinePlayerToe: UIImageView!
    @IBOutlet private weak var appUserToe: UIImageView!
    
    var playerEnemy: (() -> PlayerModel?)?
    
    private var viewModel: OnlineGameBoardViewModelProtocol!
    private var dataService: OnlineGameBoardDataService!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDataSource()
    }
    

    private func configureDataSource() {
        guard let enemy = playerEnemy?() else { dismiss(animated: true, completion: nil); return}
        unowned let this =  self
        onlinePlayerName.text = enemy.name
        viewModel = OnlineGameBoardViewModel()
        dataService = OnlineGameBoardDataService(withController: this,
                                                 with: CollectionViewGamePlay,
                                                 onlinePlayerToe: onlinePlayerToe,
                                                 appUserToe: appUserToe,
                                                 playerEnemy: enemy,
                                                 viewModel: viewModel)
        dataService.refreshAndEtechOnlinePlayer()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        dataService.playerActiveStatus(isActive: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dataService.playerActiveStatus(isActive: false)
    }
}
