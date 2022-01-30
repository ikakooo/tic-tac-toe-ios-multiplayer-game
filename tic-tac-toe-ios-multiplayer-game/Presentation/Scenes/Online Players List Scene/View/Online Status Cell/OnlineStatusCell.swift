//
//  OnlineStatusCell.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 01.12.21.
//

import UIKit

class OnlineStatusCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activeStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with:PlayerModel){
        nameLabel.text = with.name
        
        switch with.activeStatus {
            
        case true:
            activeStatus.text = "Active Now"
            activeStatus.textColor = .green
        default:
            activeStatus.text = "Offline"
            activeStatus.textColor = .black
        }
    }
}
