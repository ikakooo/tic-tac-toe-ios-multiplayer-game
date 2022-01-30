//
//  UITableViewCell+Extension.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 30.11.21.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
