//
//  GameBoardBotProfileSetUpDataService.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 22.11.21.
//

import UIKit

class GameBoardBotProfileSetUpDataService: NSObject {
    private var botProfile: RoundedImageView!
    private var botName: UILabel!
    private var humanProfile: RoundedImageView!
    
    
    
    init(with botProfile: RoundedImageView, botName: UILabel, humanProfile: RoundedImageView) {
        super.init()
        
        self.botProfile = botProfile
        self.botName = botName
        self.humanProfile = humanProfile
        
        
    }
    
    func setBotPlayer(id:Int){
        switch id {
        case 0:
            botProfile.image = UIImage.init(named: "easy_Bot")
            botName.text = "Easy Bot"
        case 1:
            botProfile.image = UIImage.init(named: "medium_bot")
            botName.text = "Medium Bot"
        case 2:
            botProfile.image = UIImage.init(named: "difficalt_bot")
            botName.text = "Difficalt Bot"
        default:
            botProfile.image = UIImage.init(named: "easy_Bot")
            botName.text = "Easy Bot"
        }
        
    }
    
    func setRandomYourProfilePhoto(){
        switch Int.random(in: 0...2) {
        case 0:
            humanProfile.image = UIImage.init(named: "p_trofile_1")
        case 1:
            humanProfile.image = UIImage.init(named: "p_trofile_2")
        case 2:
            humanProfile.image = UIImage.init(named: "p_trofile_3")
        default:
            humanProfile.image = UIImage.init(named: "p_trofile_1")
        }
    }
    
    
}
