//
//  ViewController.swift
//  EasySocialButton
//
//  Created by Antonio Zaitoun on 15/04/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var googleButton: AZSocialButton!
    
    @IBOutlet weak var facebookButton: AZSocialButton!
    
    @IBOutlet weak var twitterButton: AZSocialButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        
        googleButton.onClickAction = { (button) in
            print("google")
        }
        
        facebookButton.onClickAction = { (button) in
            print("facebook")
        }
        
        twitterButton.onClickAction = { (button) in
            print("twitter")
        }
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

