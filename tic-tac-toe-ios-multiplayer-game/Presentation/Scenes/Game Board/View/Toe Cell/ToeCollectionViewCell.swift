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
//        switch toe {
//        case "X": imgViewToe.image =  UIImage.init(named: "toe_x")
//        case "O": imgViewToe.image =  UIImage.init(named: "toe_o")
//        default: imgViewToe.image = nil
//        }
        

//        switch toe {
//        case "X": imgViewToe.image =  UIImage.init(named: "toe_x_with_border")
//        case "O": imgViewToe.image =  UIImage.init(named: "toe_o_with_border")
//        default: imgViewToe.image = UIImage.init(named: "empty_toe_space")
//        }
        
        switch toe {
        case "X":  self.imgViewToe.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.imgViewToe.image = UIImage.init(named: "toe_x")
                self.imgViewToe.transform = .identity
            }, completion: nil)
        case "O":  self.imgViewToe.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.imgViewToe.image = UIImage.init(named: "toe_o")
                self.imgViewToe.transform = .identity
            }, completion: nil)
        default: imgViewToe.image = nil //UIImage.init(named: "empty_toe_space")
            
//            self.imgViewToe.transform = CGAffineTransform(scaleX: 0, y: 0)
//            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//                self.imgViewToe.image = UIImage.init(named: "empty_toe_space")
//                self.imgViewToe.transform = .identity
//            }, completion: nil)
        }
        
       
    }

}
