//
//  ViewController.swift
//  Assignment_1
//
//  Created by Guest User on 18/06/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var appleLabel: UILabel!
    @IBOutlet weak var ballLabel: UILabel!
    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var dogLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
    }
    
    @IBAction func buttonApple(_ sender: UIButton) {
        if(appleLabel.isHidden)
        {
            appleLabel.isHidden = false
        }
        else
        {
            appleLabel.isHidden = true
        }
    }
    
    @IBAction func buttonBall(_ sender: UIButton) {
        if(ballLabel.isHidden)
        {
            ballLabel.isHidden = false
        }
        else
        {
            ballLabel.isHidden = true
        }
    }
    
    
    @IBAction func buttonCat(_ sender: UIButton) {
        if(catLabel.isHidden)
        {
            catLabel.isHidden = false
        }
        else
        {
            catLabel.isHidden = true
        }
    }
    
    @IBAction func buttonDog(_ sender: UIButton) {
        if(dogLabel.isHidden)
        {
            dogLabel.isHidden = false
        }
        else
        {
            dogLabel.isHidden = true
        }
    }
}

