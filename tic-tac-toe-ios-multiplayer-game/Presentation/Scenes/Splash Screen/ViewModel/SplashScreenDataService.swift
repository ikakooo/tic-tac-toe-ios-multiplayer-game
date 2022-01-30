//
//  SplashScreenDataService.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 20.11.21.
//

import UIKit

class SplashScreenDataService: NSObject {
    private var uiView: UIView!
    private var viewModel: SplashScreenViewModelProtocol!
    private var toes:[UIImageView]!
    
    init(view: UIView, viewModel: SplashScreenViewModelProtocol){
        super.init()
        self.uiView = view
        self.viewModel = viewModel
    }
    
    func randomNewAnimatedToes(){
        toes = viewModel.createRandomToes()
        for (sequence,toe) in toes.enumerated() {
            DispatchQueue.main.asyncAfter(deadline:  .now() + .milliseconds(sequence * 150)) {
                UIView.animate(withDuration: 2.5, animations: {[unowned self] in
                    self.uiView.addSubview(toe)
                    toe.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height + 400)
                })
            }
        }
    }
    
    
    func openGameModesScene(presentVC: @escaping (_ vc: UIViewController) -> ()){
        DispatchQueue.main.asyncAfter(deadline:  .now() + .seconds(2)) { [weak self] in
            let sb = UIStoryboard(name: "GameModeNavigationController", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "GameModeNavigationController")
            let transition = CATransition()
            
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            transition.duration = 1.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromBottom
            
            self?.uiView.window!.layer.add(transition, forKey: kCATransition)
            // present VC
            presentVC(vc)
        }
    }
}
