//
//  tic_tac_toe_ios_multiplayer_gameUITestsLaunchTests.swift
//  tic-tac-toe-ios-multiplayer-gameUITests
//
//  Created by MacBook Pro on 19.11.21.
//

import XCTest

class tic_tac_toe_ios_multiplayer_gameUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
