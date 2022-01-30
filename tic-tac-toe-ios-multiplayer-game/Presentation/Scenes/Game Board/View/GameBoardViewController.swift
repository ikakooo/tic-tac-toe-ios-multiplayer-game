//
//  GameBoardViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 20.11.21.
//

import UIKit

class GameBoardViewController: UIViewController {
    @IBOutlet private weak var CollectionViewGamePlay: UICollectionView!
    @IBOutlet private weak var botProfile: RoundedImageView!
    @IBOutlet private weak var botName: UILabel!
    
     var gameDifficalty = 0
    
    
    private var viewModel: GameBoardViewModelProtocol!
    private var dataService: GameBoardDataService!
    private var ProfileSetUpDataService: GameBoardBotProfileSetUpDataService!
    @IBOutlet private weak var humanProfile: RoundedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()

        // Do any additional setup after loading the view. GameBoardViewModel
        
        
        
    }

    private func configureDataSource() {
        viewModel = GameBoardViewModel()
        dataService = GameBoardDataService(withController: self,
                                           with: CollectionViewGamePlay,
                                           viewModel: viewModel)
        ProfileSetUpDataService = GameBoardBotProfileSetUpDataService(with: botProfile, botName: botName , humanProfile: humanProfile)
        
        
        dataService.refresh()
        ProfileSetUpDataService.setBotPlayer(id: gameDifficalty)
        ProfileSetUpDataService.setRandomYourProfilePhoto()

    }
}



