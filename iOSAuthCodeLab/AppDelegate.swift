//
//  AppDelegate.swift
//  iOSAuthCodeLab
//
//  Created by Daliso Ngoma on 30/07/2016.
//  Copyright © 2016 Daliso Ngoma. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FIRApp.configure()
        
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(
            url,
            sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String,
            annotation: options[UIApplicationLaunchOptionsAnnotationKey])
    }
    
}

