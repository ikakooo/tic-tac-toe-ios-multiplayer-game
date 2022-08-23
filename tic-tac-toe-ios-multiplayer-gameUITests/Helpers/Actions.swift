//
//  Actions.swift
//  tic-tac-toe-ios-multiplayer-gameUITests
//
//  Created by Irakli Chkhitunidzde on 23.08.22.
//

import XCTest

extension XCUIElement {
    func input(_ text: String, timeOutIfNotExitInSec: Int = 3) {
        if waitForExistence(timeout: TimeInterval(timeOutIfNotExitInSec)) {
            tap()
            typeText(text)
        }
    }
    
    func clearAndInput(_ text: String, timeOutIfNotExitInSec: Int = 3) {
        if waitForExistence(timeout: TimeInterval(timeOutIfNotExitInSec)) {
            guard let stringValue = value as? String else {
                XCTFail("Tried to clear and enter text into a non string value")
                return
            }
            tap()
            let deleteString = stringValue.map { _ in "\u{8}" }.joined()
            typeText(deleteString)
            typeText(text)
        }
    }
    
    func inputWebView(_ text: String, timeOutIfNotExitInSec: Int = 10) {
        if waitForExistence(timeout: TimeInterval(timeOutIfNotExitInSec)) {
            let app = XCUIApplication()
            UIPasteboard.general.string = text
            for _ in 1...6 { tap() }
            doubleTap()
            app.menuItems["Paste"].tap()
        }
    }
    
    func tap(timeOutIfNotExitInSec: Int) {
        if waitForExistence(timeout: TimeInterval(timeOutIfNotExitInSec)) {
            tap()
        }
    }
    
    func waitForViewVisible(timeOutIfNotExitInSec: Int) {
        if waitForExistence(timeout: TimeInterval(timeOutIfNotExitInSec)) {
            tap()
        }
    }
    func waitForViewVisibleStrictly(timeOutIfNotExitInSec: Int) {
        if !waitForExistence(timeout: TimeInterval(timeOutIfNotExitInSec)) {
            XCTAssertTrue(false)
        }
    }
    
    func tapToThisViewPosition(timeOutIfNotExitInSec: Int = 3) {
        let app = XCUIApplication()
        
        if waitForExistence(timeout: TimeInterval(timeOutIfNotExitInSec)) {
            let frame = frame
            let boardFrame = app.frame
            let position = CGVector(dx: (frame.midX) / boardFrame.maxX, dy: (frame.midY) / boardFrame.maxY)
            
            app.coordinate(withNormalizedOffset: position).tap()
        }
    }
    
    func tryTap(timeOutIfNotExitInSec: Int = 3) {
        if waitForExistence(timeout: TimeInterval(timeOutIfNotExitInSec)) && isHittable {
            tap()
        }
    }
    
    // search element with scroll
    enum Direction: Int {
        case up, down, left, right
    }
    
    func gentleSwipe(_ direction: Direction) {
        let half: CGFloat = 0.5
        let adjustment: CGFloat = 0.25
        let pressDuration: TimeInterval = 0.05
        let lessThanHalf = half - adjustment
        let moreThanHalf = half + adjustment
        let centre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))
        let aboveCentre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: lessThanHalf))
        let belowCentre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))
        let leftOfCentre = coordinate(withNormalizedOffset: CGVector(dx: lessThanHalf, dy: half))
        let rightOfCentre = coordinate(withNormalizedOffset: CGVector(dx: moreThanHalf, dy: half))
        
        switch direction {
        case .up:
            centre.press(forDuration: pressDuration, thenDragTo: aboveCentre)
        case .down:
            centre.press(forDuration: pressDuration, thenDragTo: belowCentre)
        case .left:
            centre.press(forDuration: pressDuration, thenDragTo: leftOfCentre)
        case .right:
            centre.press(forDuration: pressDuration, thenDragTo: rightOfCentre)
        }
    }
    
    func swipeUp(to element: XCUIElement) {
        var tryCount = 0
        while !(elementIsWithinWindow(element: element) || tryCount > 10) {
            XCUIApplication().gentleSwipe(.up)
            tryCount += 1
        }
    }
    
    func swipeUpAndClick(to element: XCUIElement) {
        while !(elementIsWithinWindow(element: element)) {
            XCUIApplication().gentleSwipe(.up)
            element.tap()
        }
    }
    
    private func elementIsWithinWindow(element: XCUIElement) -> Bool {
        guard element.exists && element.isHittable else {return false}
        return true
    }
    
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard exists && !frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }
    
    func switchIsOn() -> Bool {
        if value.debugDescription == "Optional(1)" {
            return true
        }
        return false
    }
    
    func disableSwitch() {
        if switchIsOn() {
            tap()
        }
    }
    
    func enableSwitch() {
        if !switchIsOn() {
            tap()
        }
    }
    
    func checkFieldValue(expectedValue: String) {
        guard let actualValue = value as? String else {
            XCTFail("Unable to get element value")
            return
        }
        XCTAssertEqual(actualValue, expectedValue)
    }
}

enum Language {
    case geo
    case eng
}

