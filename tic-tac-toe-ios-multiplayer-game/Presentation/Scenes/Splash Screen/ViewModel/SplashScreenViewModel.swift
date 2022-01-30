//
//  SplashScreenViewModel.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 20.11.21.
//

import UIKit

protocol SplashScreenViewModelProtocol: AnyObject {
    func createRandomToes() -> [UIImageView]
}

final class SplashScreenViewModel: SplashScreenViewModelProtocol {
    func createRandomToes() -> [UIImageView] {
        var toes:[UIImageView] = []
        for _ in 0...25 {
            
            let randNum:Int = Int.random(in: 0...1)
            var toe:UIImageView
            
            switch randNum {
            case 0: toe = UIImageView.init(image: UIImage.init(named: "toe_x"))
            case 1: toe = UIImageView.init(image: UIImage.init(named: "toe_o"))
            default:toe = UIImageView.init(image: UIImage.init(named: "toe_x"))
            }
            
            toe.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            toe.center = CGPoint(x: CGFloat.random(in: 40...(UIScreen.main.bounds.width-40)), y: -CGFloat(100))
            toes.append(toe)
        }
        
        return toes
    }
}
