//
//  ZephyrScaleJiraApiTCStatusUpdateObservation.swift
//  tic-tac-toe-ios-multiplayer-gameUITests
//
//  Created by Irakli Chkhitunidzde on 23.08.22.
//

import XCTest

public class ZephyrScaleJiraApiTCStatusUpdateObservation: NSObject, XCTestObservation {
    // იუზერი და პაროლი ავტორიზაციისთვის
    private let  username = ""
    private let  password = ""
    // testRunKey რომელშიც მოხდება ქეისზე სტატუსის განახლება
    private let  testRunID = ""
    private let  testingProject = "DMB-"
    private var  testCaseID = ""
    
    let update = ZephyrScaleJiraApiTCStatusUpdate()
    
    @objc(testCaseWillStart:)
    public func testCaseWillStart(_ testCase: XCTestCase) {
        testCaseID = testingProject + testCase.name.getTestNumberFromName()
        let group = DispatchGroup()
        group.enter()
        update.uploadTestResultJira(TestStatus.inprogress, nil, testRunID: testRunID, testCaseID: testCaseID, username: username, password: password) {
            group.leave()
        }
        group.wait()
    }
    
    public func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        testCaseID = testingProject + testCase.name.getTestNumberFromName()
        let group = DispatchGroup()
        group.enter()
        update.uploadTestResultJira(TestStatus.fail, "\(description) \(String(describing: filePath)) \(lineNumber)", testRunID: testRunID, testCaseID: testCaseID, username: username, password: password) {
            group.leave()
        }
        group.wait()
    }
    
    public func testCaseDidFinish(_ testCase: XCTestCase) {
        let testPassed = testCase.testRun?.hasSucceeded ?? false
        
        testCaseID = testingProject + testCase.name.getTestNumberFromName()
        let group = DispatchGroup()
        group.enter()
        if testPassed {
            update.uploadTestResultJira(TestStatus.pass, nil, testRunID: testRunID, testCaseID: testCaseID, username: username, password: password) {
                group.leave()
            }
            group.wait()
        }
    }
    
    public func testBundleDidFinish(_ testBundle: Bundle) {
        XCTestObservationCenter.shared.removeTestObserver(self)
    }
}

public enum TestStatus {
    static let pass = "Pass"
    static let fail = "Fail"
    static let inprogress = "In Progress"
    static let blocked = "Blocked"
}

fileprivate extension String {
    func getTestNumberFromName() -> String {
        guard let index = self.firstIndex(of: "_") else {return ""}
        
        var str = String(self[index...])
        str.removeFirst()
        str.removeLast()
        return str
    }
}

