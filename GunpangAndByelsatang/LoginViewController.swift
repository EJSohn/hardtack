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
    
    @IBAction func didPressKakaoBtn(_ sender: UIButton) {
    }
    
    @IBAction func didPressFacebookBtn(_ sender: UIButton) {
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
