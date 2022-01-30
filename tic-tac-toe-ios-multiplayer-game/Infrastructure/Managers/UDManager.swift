//
//  UDManager.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 30.11.21.
//

import Foundation

struct UDManager {
    
    // MARK: - Keys
    
   
    private static let KEY_IS_USER_LOGGED_IN = "KEY_IS_USER_LOGGED_IN"
    private static let KEY_USER_UID = "KEY_USER_UID"
    private static let KEY_USER_EMAIL = "KEY_USER_EMAIL"
    private static let KEY_USER_NAME = "KEY_USER_NAME"
    
    
    private static var ud = UserDefaults.standard
    
    
    static func markUserAsLoggedOut() {
        ud.set(false, forKey: KEY_IS_USER_LOGGED_IN)
        ud.set("",forKey: KEY_USER_UID)
        ud.set("",forKey: KEY_USER_EMAIL)
        ud.set("",forKey: KEY_USER_NAME)
    }
    
    static func isUserLoggedIn() -> Bool {
        
        ud.bool(forKey: KEY_IS_USER_LOGGED_IN)
        //return false
    }
    
    static func saveUserAndMarkUserAsLoggedIn(user: PlayerModel) {
        ud.set(true, forKey: KEY_IS_USER_LOGGED_IN)
        ud.set(user.uid, forKey: KEY_USER_UID)
        ud.set(user.Email, forKey: KEY_USER_EMAIL)
        ud.set(user.name,forKey: KEY_USER_NAME)
    }
    
    static func getLoggedInUser() -> PlayerModel {
        let islogged = ud.bool(forKey: KEY_IS_USER_LOGGED_IN)
        let uid = ud.string(forKey: KEY_USER_UID)
        let Email = ud.string(forKey: KEY_USER_EMAIL)
        let name = ud.string(forKey: KEY_USER_NAME)
        
        
       return PlayerModel(uid: uid, Email: Email, name: name, activeStatus: islogged)
    }
}
