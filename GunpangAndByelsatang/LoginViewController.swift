//
//  LoginViewController.swift
//  GunpangAndByelsatang
//
//  Created by 손은주 on 2017. 7. 2..
//  Copyright © 2017년 Ejsohn. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit

/**
 Initial login view controller.
 */

class LoginViewController: UIViewController,  GIDSignInUIDelegate {
    
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    @IBOutlet weak var facebookLoginBtn: UIButton!
    @IBOutlet weak var googleSigninBtn: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func didPressFacebookBtn(_ sender: UIButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                log.info("firebase login with facebook success.")
                
            })
        }
    }
    
    @IBAction func didPressKakaoBtn(_ sender: UIButton) {
    }

    @IBAction func test(_ sender: UIButton) {
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let dialog = UIAlertController(title: user.displayName, message: user.email, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
        dialog.addAction(action)
        
        self.present(dialog, animated: true, completion: nil)
    }

}
