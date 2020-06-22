//
//  Extension + NSMutableAttributedString.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 22.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            
           self.addAttribute(.link, value: linkURL, range: foundRange)
            
            return true
        }
        return false
    }
}

extension UIColor {
    static var mainAppColor: UIColor {
        return UIColor(red: 0, green: 0.7216, blue: 0.7569, alpha: 1.0)
    }
}
