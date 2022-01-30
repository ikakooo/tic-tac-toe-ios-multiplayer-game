//
//  SplashScreenViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 19.11.21.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    private var viewModel: SplashScreenViewModelProtocol!
    private var dataService: SplashScreenDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
    }
    
    
    private func configureDataSource() {
        viewModel = SplashScreenViewModel()
        dataService = SplashScreenDataService(view: view, viewModel: viewModel)
        
        dataService.randomNewAnimatedToes()
        dataService.openGameModesScene(){ [weak self]  vc in
            self?.present(vc, animated: true, completion: nil)
        }
    }
}
