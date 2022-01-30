//
//  OnlineWelcomeViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 27.11.21.
//

import UIKit

class OnlineWelcomeViewController: UIViewController, LoginDelegate {
    func logIn() {
        let sb = UIStoryboard(name: "OnlinePlayersListViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "OnlinePlayersListViewController") as? OnlinePlayersListViewController else {return}
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
    }
    
    @IBAction func onCreateAcountClick(_ sender: Any){
        
        let storyboard = UIStoryboard(name: "CreateAccountViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        
        viewController.delegate = self
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.large()] /// set here!
        }
        
//        viewController.vcStealer = { [unowned self] in
//            return self
//        }
        
        self.present(viewController, animated: true)
        
    }
    @IBAction func onLoginClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LogInViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        viewController.delegate = self
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.large()] /// set here!
        }
        
//        viewController.vcStealer = { [unowned self] in
//            return self
//        }
        
        self.present(viewController, animated: true)
        
    }
    
}

protocol LoginDelegate {
    func logIn()
}
