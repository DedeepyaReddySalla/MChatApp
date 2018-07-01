//
//  SignInVC.swift
//  MChatApp
//
//  Created by Dedeepya reddy Salla on 7/1/18.
//  Copyright © 2018 Motion Mentoring Org. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    @IBOutlet weak var googlSignInCustomBtn: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
    //button customization
//        let btnSize: CGFloat = 200
//        googlSignInCustomBtn.layer.cornerRadius = 10
//        googlSignInCustomBtn.layer.masksToBounds = true
//        googlSignInCustomBtn.layer.borderColor = UIColor.gray.cgColor
//        googlSignInCustomBtn.layer.borderWidth = 1
//        googlSignInCustomBtn.layer.shadowColor = UIColor.gray.cgColor
//        googlSignInCustomBtn.layer.shadowOffset = CGSize(width:200, height: 200)
//        googlSignInCustomBtn.frame = CGRect(x: 0, y: 0, width:btnSize, height:btnSize)
//        googlSignInCustomBtn.center = view.center
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        //        self.navigationController?.popViewController(animated: true)
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        let submitVC:SubmitQstnVC = (storyboard!.instantiateViewController(withIdentifier: "SubmitQstnVCIden") as? SubmitQstnVC)!
        
        //app signing in to get user credentials from gmail server
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            //MARK: - Navigation
            if let userName = user?.email{
                print(userName as Any)
                //MARK:  - Saving user state
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                UserDefaults.standard.set(userName, forKey: "user")
                submitVC.userName = userName
                self.navigationController?.pushViewController(submitVC, animated: true)
            }
        }// end of auth signing in
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
