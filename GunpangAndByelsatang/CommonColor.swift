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
    
    private var _main: UIColor = UIColor(red: 178/255, green: 255/255, blue: 89/255, alpha: 1)
    
    public var main: UIColor {
        get {
            
            return _main
        }
        
        set(color){
            if color != UIColor.white {
                _main = color
            } else {
                log.warning("Main color can't be white.")
            }
        }
    }
    
    init() { }
}
