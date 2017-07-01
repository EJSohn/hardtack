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
    
    static let shared = CommonColor()
    
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
        with main:UIColor = UIColor.black,
        and sub: UIColor = UIColor.white) {
        
        self.main = main
        self.sub = sub
    }
}
