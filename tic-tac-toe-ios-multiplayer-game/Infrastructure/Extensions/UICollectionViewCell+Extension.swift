//
//  UICollectionViewCell+Extension.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 20.11.21.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }
    
    func gridAnimationCell(indexPath: IndexPath){
        self.alpha = 0.5
        self.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.45, delay: 0, options: .curveEaseOut, animations: {
          self.alpha = 1
          self.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
}
