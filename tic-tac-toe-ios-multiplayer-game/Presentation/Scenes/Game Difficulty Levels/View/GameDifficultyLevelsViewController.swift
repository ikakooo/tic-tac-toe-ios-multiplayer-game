//
//  GameDifficultyLevelsViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 20.11.21.
//

import UIKit

class GameDifficultyLevelsViewController: UIViewController {
    
    private var dataService: GameDifficultyLevelsDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view. GameDifficultyLevelsDataService
        configureDataSource()
    }
    
    
    private func configureDataSource() {
        dataService = GameDifficultyLevelsDataService(view: view)
    }
    
    @IBAction func onDifficaltyButtonClick(_ sender: GradientViewUIButton) {
        dataService.openGameBoardScene(gameDifficalty: sender.tag){ [weak self] vc in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}
