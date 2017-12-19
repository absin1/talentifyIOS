//
//  TaskScreenController.swift
//  Talentify
//
//  Created by Feroz on 12/19/17.
//  Copyright © 2017 iSTAR Skill Development Pvt. Ltd. All rights reserved.
//

import UIKit

class TaskScreenController: UIViewController {
    
    @IBOutlet weak var rootTopView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pinBackground(backgroundView, to: rootTopView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.talentifyRed
        
        return view
    }()
    
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
    
}
public extension UIView {
    public func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
extension UIColor {
    static let talentifyRed = UIColor(red: 235/255, green: 56/255, blue: 79/255, alpha: 1)
}
