//
//  GameDifficultyLevelsDataService.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 20.11.21.
//

import UIKit

class GameDifficultyLevelsDataService: NSObject {
    
    private var uiView: UIView!
    
    
    init(view: UIView){
        super.init()
        self.uiView = view
    }
    
    
    func openGameBoardScene(gameDifficalty:Int, presentVC: @escaping (_ vc: UIViewController) -> ()){
        DispatchQueue.main.async {
            //            let navigation = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
            //               navigation.myData = "Data that you want to pass"
            //               present(navigation, animated: true, completion: nil)
            
            let sb = UIStoryboard(name: "GameBoardViewController", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "GameBoardViewController") as? GameBoardViewController else {return}
            
            // pass data
            
            vc.gameDifficalty = gameDifficalty
            
            let transition = CATransition()
            
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            
            self.uiView.window!.layer.add(transition, forKey: kCATransition)
            // present VC
            presentVC(vc)
        }
    }
}
