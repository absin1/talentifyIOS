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
        urlComponents.host = "localhost"
        urlComponents.port = 4567
        urlComponents.path = "/hello"
        //let userEmailItem = URLQueryItem(name: "email", value: "demo169920@istarindia.com")
        //let userPassItem = URLQueryItem(name: "password", value: "test123")
        //urlComponents.queryItems = [userEmailItem,userPassItem]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
         var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                guard responseError == nil else {
                    print(responseError)
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
               print(jsonData)
            }
        }
        
        task.resume()
          

    }
}
