//
//  ToesRainUIView.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 19.11.21.
//

import Foundation
import UIKit

final class ToesRainUIView: UIView{
    @IBInspectable var toesCount: Int = 6 {
        didSet {
            self.updateView()
        }
    }
    
    
    //Apply params
    func updateView() {
        self.backgroundColor = .black
//        self.layer.shadowColor = self.shadowColor.cgColor
//        self.layer.shadowOpacity = self.shadowOpacity
//        self.layer.shadowOffset = self.shadowOffset
//        self.layer.shadowRadius = self.shadowRadius
    }
    
}
