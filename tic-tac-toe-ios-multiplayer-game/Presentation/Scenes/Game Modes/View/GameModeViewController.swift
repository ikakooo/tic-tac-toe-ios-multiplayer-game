//
//  GameModeViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 20.11.21.
//

import UIKit

class GameModeViewController: UIViewController {
    
    private var dataService: GameModeDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.  GameModeDataService
        configureDataSource()
    }
    
    private func configureDataSource() {
        //        dataService = GameModeDataService(view: view)
    }
    
    @IBAction func onSinglePlayerClick(_ sender: Any) {
        //        var viewController: UIViewController? = storyboard.instantiateViewController(withIdentifier: "GameDifficultyLevelsNavigationController")
        //        let sb = UIStoryboard(name: "GameDifficultyLevelsNavigationController", bundle: nil)
        //        let vc = sb.instantiateViewController(withIdentifier: "GameDifficultyLevelsNavigationController")
        //        let navi = UINavigationController(rootViewController: vc)
        //        navigationController?.pushViewController(navi, animated: true)
        
        //        dataService.openGameBoardScene(){ [weak self] vc in
        //            self?.present(vc, animated: true, completion: nil)
        //
        //        }
    }
    @IBAction func onMultiplayerClick(_ sender: Any) {
        
        if UDManager.isUserLoggedIn() {
            
            let sb = UIStoryboard(name: "OnlinePlayersListViewController", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "OnlinePlayersListViewController") as? OnlinePlayersListViewController else {return}
            navigationController?.pushViewController(vc, animated: true)
        }else {
            let sb = UIStoryboard(name: "OnlineWelcomeViewController", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "OnlineWelcomeViewController") as? OnlineWelcomeViewController else {return}
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    @IBAction func onLocalMultiplayerClick(_ sender: Any) {
        
    }
    @IBAction func onThemesClick(_ sender: Any) {
        
    }
    
}
