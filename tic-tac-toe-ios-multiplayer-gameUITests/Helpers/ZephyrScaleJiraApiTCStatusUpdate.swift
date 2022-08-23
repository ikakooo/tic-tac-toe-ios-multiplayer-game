//
//  ZephyrScaleJiraApiTCStatusUpdate.swift
//  tic-tac-toe-ios-multiplayer-gameUITests
//
//  Created by Irakli Chkhitunidzde on 23.08.22.
//

import Foundation

struct ZephyrScaleJiraApiTCStatusUpdate {
    func uploadTestResultJira(_ status: String, _ failureDescription: String?, testRunID: String, testCaseID: String, username: String, password: String, completion: @escaping(() -> Void)) {
        let baseURI =  "https://jira.tbcbank.ge"
        let path = "/rest/atm/1.0/testrun/" + testRunID + "/testcase/" + testCaseID + "/testresult"
        
        let loginString = "\(username):\(password)"
        
        guard let loginData = loginString.data(using: .utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        // Create url object
        guard let url = URL(string: baseURI + path) else {return}
        
        // Create the session object
        let session = URLSession.shared
        
        // Create the URLRequest object using the url object
        var request = URLRequest(url: url)
        
        // Set the request method. Important Do not set any other headers, like Content-Type
        request.httpMethod = "POST" // set http method as POST
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
       
        let infoMessage = """
                          The test result has updated on some automation tool procedure \(failureDescription ?? "")
                          """
        
        let json: [String: String] = ["status": "\(status)", "comment": infoMessage]
        
        let postData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = postData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("x-requested-with", forHTTPHeaderField: "origin")
        
        // Create a task using the session object, to run and return completion handler
        let webTask = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            guard let serverData = data else {
                print("server data error")
                return
            }
            completion()
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                }
                if let requestJson = try JSONSerialization.jsonObject(with: serverData, options: .mutableContainers) as? [String: Any] {
                    print("Response: \(requestJson)")
                }
            } catch {
                let message = String(bytes: serverData, encoding: .ascii)
                print(message as Any)
            }
        })
        // Run the task
        webTask.resume()
    }
}
