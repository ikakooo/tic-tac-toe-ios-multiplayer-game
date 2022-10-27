//
//  GameModesUITests.swift
//  tic-tac-toe-ios-multiplayer-gameUITests
//
//  Created by Irakli Chkhitunidzde on 23.08.22.
//

import XCTest

class GameModesUITests: XCTestCase, GameModesPage {
    
    func testSinglePlayerButtonVisible_T2132() {
        singlePlayerButton.waitForViewVisibleStrictly(timeOutIfNotExitInSec: generalTimeout)
        
        XCTAssertTrue(singlePlayerButton.exists)
    }
    
    func testMultiplayerButtonVisible_T2132() {
        multiplayerButton.waitForViewVisibleStrictly(timeOutIfNotExitInSec: generalTimeout)
        
        XCTAssertTrue(multiplayerButton.exists)
    }
    
    func testLocalMultiplayerButtonVisible_T2132() {
        localMultiplayerButton.waitForViewVisibleStrictly(timeOutIfNotExitInSec: generalTimeout)
        
        XCTAssertTrue(localMultiplayerButton.exists)
    }
    
    func testThemesButtonVisible_T2132() {
        themesButton.waitForViewVisibleStrictly(timeOutIfNotExitInSec: generalTimeout)
        
        XCTAssertTrue(themesButton.exists)
    }
    
}
