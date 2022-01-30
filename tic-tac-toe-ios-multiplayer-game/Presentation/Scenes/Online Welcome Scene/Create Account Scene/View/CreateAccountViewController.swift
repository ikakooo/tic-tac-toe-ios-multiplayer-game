//
//  CreateAccountViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 27.11.21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var usernameLabel: FloatingLabelInput!
    @IBOutlet weak var emailLabel: FloatingLabelInput!
    @IBOutlet weak var passwordLabel: FloatingLabelInput!
    @IBOutlet weak var confirmPasswordLabel: FloatingLabelInput!
    
    var delegate:LoginDelegate?
    
    private var viewModel: CreateAccountViewModelProtocol!
    private var dataService: CreateAccountDataService!
    
   // var vcStealer: (() -> UIViewController?)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view. CreateAccountDataService
        configureDataSource()
    }
    
    private func configureDataSource() {
        unowned let vc = self
        viewModel = CreateAccountViewModel()
        dataService = CreateAccountDataService(withController: vc,
                                               usernameLabel: usernameLabel,
                                               emailLabel: emailLabel,
                                               passwordLabel: passwordLabel,
                                               confirmPasswordLabel: confirmPasswordLabel,
                                               logInDelegate: delegate,
                                               
                                               viewModel: viewModel)
    }
    
    @IBAction func onUsernameTextChange(_ sender: Any) {
        dataService.updateUsernameInputStatus()
    }
    
    @IBAction func onEmailTextChange(_ sender: Any) {
        dataService.updateEmailInputStatus()
    }
    
    @IBAction func onPasswordTextChange(_ sender: Any) {
        dataService.updatePasswordInputStatus()
        dataService.updateConfirmPasswordInputStatus()
    }
    @IBAction func onConfirmPasswordTextChange(_ sender: Any) {
        dataService.updateConfirmPasswordInputStatus()
    }
    
    
    @IBAction func onCloseClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onRegisterClick(_ sender: Any) {
        dataService.updateUsernameInputStatus()
        dataService.updateEmailInputStatus()
        dataService.updatePasswordInputStatus()
        dataService.updateConfirmPasswordInputStatus()
        dataService.tryCreateAccount()
    }
    @IBAction func onLoginClick(_ sender: Any) {
        
        //self.dismiss(animated: true, completion: {
            
//          //  DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                let storyboard = UIStoryboard(name: "LogInViewController", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
//
//                if let presentationController = viewController.presentationController as? UISheetPresentationController {
//                    presentationController.detents = [.large()] /// set here!
//                }
//
//
//                viewController.vcStealer = { [weak self] in
//                    return self?.vcStealer?()
//                }
//
//                self.dismiss(animated: true, completion: {
//
//                    self.vcStealer?()?.present(viewController, animated: true)
//                })
           // }
            
        //})
        
        let storyboard = UIStoryboard(name: "LogInViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.large()] /// set here!
        }
        
//        viewController.vcStealer = { [weak self] in
//            return self?.vcStealer?()
//        }
        let presenter = self.presentingViewController
        self.dismiss(animated: true, completion: {
            presenter?.present(viewController, animated: true)
           // self.vcStealer?()?.present(viewController, animated: true)
        })
    }
}



