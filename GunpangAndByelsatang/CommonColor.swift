//
//  CommonColor.swift
//  GunpangAndByelsatang
//
//  Created by 손은주 on 2017. 7. 2..
//  Copyright © 2017년 Ejsohn. All rights reserved.
//

import UIKit
import Foundation


/**
    This is class that deal with app's colors
 */
class CommonColor {
    
    static let shared = CommonColor(with: nil)
    
    public var main: UIColor {
        get {
            
            return self.main
        }
        
        set(color){
            self.main = color
        }
    }
    
    public var sub: UIColor {
        get {
            return self.sub
        }
        
        set(color){
            self.sub = color
        }
    }
    
    init(
        with main:UIColor?,
        and sub: UIColor = UIColor.white) {
        
        if let main = main {
            self.main = main
        } else {
            // default color (hex #b2ff59)
            self.main = UIColor(red: 178/255, green: 255/255, blue: 89/255, alpha: 1)
        }
        self.sub = sub
    }
}
