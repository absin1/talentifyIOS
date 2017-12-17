//
//  LoginController.swift
//  Talentify
//
//  Created by Feroz on 12/15/17.
//  Copyright © 2017 iSTAR Skill Development Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "Email Id"
        passwordTextField.placeholder = "Password"
    }
    
    // MARK: Actions
    @IBAction func loginButton(_ sender: UIButton) {
        print("Button pressed")
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "alpha.talentify.in"
        urlComponents.port = 9090
        urlComponents.path = "/istar/rest/auth/login"
        //let userEmailItem = URLQueryItem(name: "email", value: "demo169920@istarindia.com")
        //let userPassItem = URLQueryItem(name: "password", value: "test123")
        //urlComponents.queryItems = [userEmailItem,userPassItem]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
         var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        let postString = "email=demo169920@istarindia.com&password=test123"
        request.httpBody = postString.data(using: .utf8)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                guard responseError == nil else {
                    print(responseError as Any)
                    return
                }
                
                guard let jsonData = responseData else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    print(error)
                    return
                }
                // Now we have jsonData, Data representation of the JSON returned to us
                // from our URLRequest...
                
                // Create an instance of JSONDecoder to decode the JSON data to our
                // Codable struct
                do {
                    if let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                        let studentProfile=json["studentProfile"]  as? [String: Any]
                        print(studentProfile!["name"])
                    }
                } catch let parseError {
                    print("parsing error: \(parseError)")
                    let responseString = String(data: jsonData, encoding: .utf8)
                    print("raw response: \(String(describing: responseString))")
                }
            }
        }
        
        task.resume()
          

    }
}
