//
//  ToeCollectionViewCell.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 21.11.21.
//

import UIKit

class ToeCollectionViewCell: UICollectionViewCell {
    let imgViewToe: UIImageView = {
           let theImageView = UIImageView()
           theImageView.translatesAutoresizingMaskIntoConstraints = false
           return theImageView
        }()
    
    let toeWidthHeight = UIScreen.main.bounds.width / 3 - 15 - 15
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewToe.frame = CGRect(x: 0, y: 0, width: self.bounds.width - 5, height: self.bounds.height - 5 )
        
        self.addSubview(imgViewToe)
        
        imgViewToe.widthAnchor.constraint(equalToConstant: toeWidthHeight).isActive = true
        imgViewToe.heightAnchor.constraint(equalToConstant: toeWidthHeight).isActive = true
        imgViewToe.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imgViewToe.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    func configure(with toe: String) {
        imgViewToe.alpha = 0.1
        switch toe {
        case "X":  self.imgViewToe.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.imgViewToe.image = UIImage.init(named: "toe_x")
                self.imgViewToe.alpha = 1.0
                self.imgViewToe.transform = CGAffineTransform.identity.scaledBy(x: 1.3, y: 1.3)
             }) { (finished) in
                 UIView.animate(withDuration: 0.5, animations: {
                  self.imgViewToe.transform = CGAffineTransform.identity // undo in 1 seconds
               })
            }
        case "O":  self.imgViewToe.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.imgViewToe.image = UIImage.init(named: "toe_o")
                self.imgViewToe.alpha = 1.0
                self.imgViewToe.transform = CGAffineTransform.identity.scaledBy(x: 1.3, y: 1.3)
             }) { (finished) in
                 UIView.animate(withDuration: 0.5, animations: {
                  self.imgViewToe.transform = CGAffineTransform.identity // undo in 1 seconds
               })
            }
        default: imgViewToe.image = nil //UIImage.init(named: "empty_toe_space")
        }
    }
}
