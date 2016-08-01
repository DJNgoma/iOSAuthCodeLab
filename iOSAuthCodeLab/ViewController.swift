//
//  ViewController.swift
//  iOSAuthCodeLab
//
//  Created by Daliso Ngoma on 30/07/2016.
//  Copyright © 2016 Daliso Ngoma. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet var signInButton: GIDSignInButton?
    @IBOutlet var signOutButton: UIButton?
    @IBAction func signOutClicked() {
        // Start Auth Sign Out
        let firebaseAuth: FIRAuth? = FIRAuth.auth()
        
        do {
            try firebaseAuth?.signOut()
        } catch {
            print("Error in signout out")
        }
        // End Auth Sign Out
        
        self.signInButton?.enabled = true
        self.signOutButton?.enabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        signOutButton?.enabled = false
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        if error == nil {
            let authentication: GIDAuthentication = user.authentication
            let credential: FIRAuthCredential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
            
            FIRAuth.auth()?.signInWithCredential(credential) { [unowned self] (user, error) in
                
                if user != nil {
                    let userName: String? = user?.displayName!
                    guard userName != nil else { return }
                    
                    let welcomeMessage: String? = "Welcome to Firebase \(userName!)"
                    let alertTitle: String? = "Firebase Auth Codelab"
                    
                    let alertController: UIAlertController = UIAlertController(
                        title: alertTitle,
                        message: welcomeMessage,
                        preferredStyle: .Alert)
                    
                    let okAction: UIAlertAction = UIAlertAction(
                        title: NSLocalizedString("OK", comment: "Ok Action"),
                        style: .Default,
                        handler: { (action) in print("OK Action")}
                    )
                    
                    alertController.addAction(okAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    self.signInButton?.enabled = false
                    self.signOutButton?.enabled = true
                }
            }
        } else {
            print("Something went wrong")
        }
    }
}

