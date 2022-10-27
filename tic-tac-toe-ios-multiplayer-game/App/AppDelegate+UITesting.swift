//
//  AppDelegate+UITesting.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by Irakli Chkhitunidzde on 27.10.22.
//

import UIKit

extension AppDelegate {
    static var isUITestingEnabled: Bool {
        ProcessInfo.processInfo.arguments.contains("UI-Testing")
    }

    func setStateForUITesting() {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier, AppDelegate.isUITestingEnabled == true else { return }
        let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = scenes?.windows.first { $0.isKeyWindow }
        // To clear app state
        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        // To speed up UI tests
        window?.layer.speed = 10
        UIView.setAnimationsEnabled(false)
    }
}
