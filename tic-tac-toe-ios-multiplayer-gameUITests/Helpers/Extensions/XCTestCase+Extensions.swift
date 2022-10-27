//
//  XCTestCase+Extensions.swift
//  tic-tac-toe-ios-multiplayer-gameUITests
//
//  Created by Irakli Chkhitunidzde on 27.10.22.
//

import XCTest

private(set) var app = XCUIApplication()

// Wait Times
public let timeout = 2
public let timeoutInterval: TimeInterval = 2
public let nanoTimeout = 3
public let minimumTimeout = 5
public let generalTimeout = 10
public let intermediateTimeout = 15
public let maximumTimeout = 20
public let ultimateTimeout = 90

extension XCTestCase {
    
    open override func setUp() {
        super.setUp()
        continueAfterFailure = true
        launchApp()
        app.tap()
        XCTestObservationCenter.shared.addTestObserver(ZephyrScaleJiraApiTCStatusUpdateObservation())
    }
    
    fileprivate func launchApp() {
        app = XCUIApplication()
        app.launchArguments.append("UI-Testing")
        app.launch()
    }
    
    func relaunchApp() {
        super.tearDown()
        launchApp()
    }
}
