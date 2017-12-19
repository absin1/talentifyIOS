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
    
    struct studentProfile: Codable {
        let batchRank: Int
        let password: String
        let userCategory: String
        let isVerified: Bool
        let coins: Int
        let name: String
        let mobile: Int
        let experiencePoints: Int
        let id: Int
        let profileImage: String
        let userType: String
        let email: String
    }
    
    struct ComplexObject: Codable
    {
        let studentProfile: studentProfile
        let id: Int
    }
    
    
    
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    func getComplex(completion: ((Result<ComplexObject>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "alpha.talentify.in"
        urlComponents.port = 9090
        urlComponents.path = "/istar/rest/auth/login"
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
                let decoder = JSONDecoder()
                
                do {
                    // We would use Post.self for JSON representing a single Post
                    // object, and [Post].self for JSON representing an array of
                    // Post objects
                    let complex =  try decoder.decode(ComplexObject.self, from: jsonData)
                    completion?(.success(complex))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    
    var complex: ComplexObject?
    
    // MARK: Actions
    @IBAction func loginButton(_ sender: UIButton) {
        
        print("Button pressed")
        getComplex() { (result) in
            switch result {
            case .success(let posts):
                self.complex = posts
                //print(self.complex?.studentProfile.name)
                //print(self.complex?.studentProfile.batchRank)
                // print(self.complex?.studentProfile.coins)
            // print(self.complex?.studentProfile.id)
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
}
