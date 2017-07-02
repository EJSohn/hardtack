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

extension AppDelegate: GIDSignInDelegate, GIDSignInUIDelegate {
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn
                .sharedInstance().handle(url,
                    sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                    annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            log.error(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider
            .credential(
                withIDToken: authentication.idToken,
                accessToken: authentication.accessToken)
        
        log.info("user trying to signed in with google account:")
        log.info(credential)
        
        Auth.auth().signIn(with: credential){ (user, error) in
            if let error = error {
                log.error("error; \(error)")
                return
            }
            
            log.info("firebase signin with google success.")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        log.info("user disconnected")
    }
    
}
