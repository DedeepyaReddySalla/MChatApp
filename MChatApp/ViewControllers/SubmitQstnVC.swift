//
//  SubmitQstnVC.swift
//  MChatApp
//
//  Created by Dedeepya reddy Salla on 7/1/18.
//  Copyright © 2018 Motion Mentoring Org. All rights reserved.
//

import UIKit
import MessageUI
import FirebaseAuth
import GoogleSignIn

class SubmitQstnVC: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var userNameLBL: UILabel!
     var userName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //        let firebaseAuth = Auth.auth()
    //            do {
    //                try Auth.auth().signOut()
    //                self.navigationController?.popViewController(animated: true)
    //            }
    //            catch {
    //            }
    
    @IBAction func signOut(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            UserDefaults.standard.set(false, forKey: "userLoggedIn")
            GIDSignIn.sharedInstance().signOut()
            //remove the signIn VC from navigation stack array, so when you pop this vc..
            //you will be directed to home page
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func submitQstn(_ sender: Any) {
        let mailComposeViewController = configureMFMailComposer()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion:nil)
        }else{
            showEmailError()
        }
    }
    
    func configureMFMailComposer() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["dedeepyareddy255@gmail.com"])
        mailComposerVC.setSubject("Hello")
        mailComposerVC.setMessageBody("message body", isHTML:false)
        return mailComposerVC
    }
    
    func showEmailError(){
        let sendMailErrorAlert = UIAlertController(title:"Error", message:"There is no email setUp", preferredStyle: .alert)
        let dismiss = UIAlertAction(title:"Ok", style:.default, handler:nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated:true, completion:nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated:true, completion:nil)
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
