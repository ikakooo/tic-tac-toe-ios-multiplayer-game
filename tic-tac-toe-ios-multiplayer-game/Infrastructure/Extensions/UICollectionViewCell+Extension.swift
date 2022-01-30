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
}
