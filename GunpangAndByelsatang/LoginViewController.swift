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
import FBSDKLoginKit
import FBSDKCoreKit

/**
 Initial login view controller.
 */

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    @IBOutlet weak var facebookLoginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
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
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
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
                    log.error("Login error: \(error.localizedDescription)")
                    return
                }
                
                log.info("firebase login with facebook success.")
                
            })
        }
    }
    
    @IBAction func didPressKakaoBtn(_ sender: UIButton) {
        let session: KOSession = KOSession.shared();
        if session.isOpen() {
            session.close()
        }
        session.presentingViewController = self
        session.open(completionHandler: { (error) -> Void in
            if let error = error {
                log.error(error)
            }else if session.isOpen() == true{
                log.info("kakao login success.")
                log.info("with token: \(session.accessToken)")
                
                KOSessionTask.meTask(
                    completionHandler: {(profile, error) -> Void in
                        if let user: KOUser = profile as? KOUser {
                            Auth.auth().createUser(withEmail: user.email!, password: user.email!){ (user, error) in
                                if let error = error
                                {
                                    log.error(error)
                                    return
                                }
                                
                                log.info("firebase login with kakao success.")
                            }
                        }
                })
            }
        })
    }
    
    @IBAction func didPressGoogleBtn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
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
