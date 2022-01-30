//
//  UICollectionView+Extension.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 20.11.21.
//

import UIKit

extension UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(class: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func deque<T: UICollectionViewCell>(class: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
