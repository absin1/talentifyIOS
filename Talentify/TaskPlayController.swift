//
//  TaskPlayController.swift
//  Talentify
//
//  Created by absin on 12/20/17.
//  Copyright © 2017 iSTAR Skill Development Pvt. Ltd. All rights reserved.
//

import UIKit

class TaskPlayController: UIViewController {
    @IBOutlet weak var optionView1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.talentifyRed
        optionView1.layer.borderWidth = 1
        optionView1.layer.cornerRadius = 2
        optionView1.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 231/255, alpha: 1).cgColor
    }
}

