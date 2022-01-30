//
//  LogInViewController.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 28.11.21.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    @IBOutlet weak var emailFild: FloatingLabelInput!
    @IBOutlet weak var passwordFild: FloatingLabelInput!
    
   // var vcStealer: (() -> UIViewController?)?
    

     var delegate:LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //passwordFild.enablePasswordVisibilityToggle()
        // Do any additional setup after loading the view.  LogInViewDataService
    }
    
    @IBAction func onEmailTextChange(_ sender: FloatingLabelInput) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        var image: UIImage? = nil
        guard let emailText = sender.text else {return}
        sender.rightViewMode = UITextField.ViewMode.always
        
        if emailText.isValidEmail(){
            image = UIImage(named: "ic_correct");
        } else {
            image = UIImage(named: "ic_error");
        }
        
        
        imageView.image = image
        sender.rightView = imageView
        
        
    }
    
    @IBAction func onPasswordTextChange(_ sender: FloatingLabelInput) {
        
        
    }
    
    
    
    
    
    
    
    @IBAction func onCloseClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onRegisterClick(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        
//        let storyboard = UIStoryboard(name: "CreateAccountViewController", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CreateAccountViewController")
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.vcStealer?().present(vc, animated: true, completion: nil)
        
        
        let storyboard = UIStoryboard(name: "CreateAccountViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.large()] /// set here!
        }
        
//        viewController.vcStealer = { [weak self] in
//            return self?.vcStealer?()
//        }
        let presenter = self.presentingViewController
        self.dismiss(animated: true, completion: {
            presenter?.present(viewController, animated: true)
            //self.vcStealer?()?.present(viewController, animated: true)
        })
        
        
    }
    
    
    
    
    
    
    
    @IBAction func onLoginClick(_ sender: Any) {
        
        guard
            let email = emailFild.text,
            let password = passwordFild.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "Sign In Failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true, completion: nil)
            }else {
                UDManager.saveUserAndMarkUserAsLoggedIn(user: PlayerModel(Email:email,activeStatus: true))
                self?.dismiss(animated: true, completion: {
                    //vc.login = true
                    self?.delegate?.logIn()
                })
                
            }
        }
    }
}

