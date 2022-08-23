//
//  GameModesPage.swift
//  tic-tac-toe-ios-multiplayer-gameUITests
//
//  Created by Irakli Chkhitunidzde on 23.08.22.
//

import XCTest

class GameModesPage: UITestsBaseRunner {
    var singlePlayerButton: XCUIElement { app.staticTexts["Single Player"] }
    var backButton: XCUIElement { app.buttons["Back"] }
    var multiplayerButton: XCUIElement { app.buttons["Multiplayer"] }
    var localMultiplayerButton: XCUIElement { app.staticTexts["Local Multiplayer"] }
    var themesButton: XCUIElement { app.buttons["Themes"] }
}
