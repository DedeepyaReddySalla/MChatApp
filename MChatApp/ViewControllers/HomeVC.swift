//
//  HomeVC.swift
//  MChatApp
//
//  Created by Dedeepya reddy Salla on 7/1/18.
//  Copyright © 2018 Motion Mentoring Org. All rights reserved.
//

import UIKit
import GoogleSignIn

class HomeVC: UIViewController {
//  var userName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askQuestion(_ sender: Any) {
        if let user = GIDSignIn.sharedInstance().currentUser {
            let submitVC:SubmitQstnVC = (storyboard!.instantiateViewController(withIdentifier: "SubmitQstnVCIden") as? SubmitQstnVC)!
            if let userEmail = user.profile.email
            {
//              userName = userEmail
                submitVC.userName = userEmail
                print(userEmail)
                self.navigationController?.pushViewController(submitVC, animated: true)
            }
        }
        else
        {
            let signInVC:SignInVC = (storyboard!.instantiateViewController(withIdentifier: "SignInIden") as? SignInVC)!
            self.navigationController?.pushViewController(signInVC, animated: true)
        }
    }
    
}

