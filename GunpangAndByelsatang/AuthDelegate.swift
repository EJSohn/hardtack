//
//  AuthDelegate.swift
//  GunpangAndByelsatang
//
//  Created by 손은주 on 2017. 7. 2..
//  Copyright © 2017년 Ejsohn. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
import FBSDKCoreKit


extension AppDelegate {
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            if KOSession.isKakaoAccountLoginCallback(url) {
                return KOSession.handleOpen(url)
            }
            
            let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options)
            
            return handled || GIDSignIn
                .sharedInstance().handle(url,
                    sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                    annotation: [:])
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return false
    }
    
}
