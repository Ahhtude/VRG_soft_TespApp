//
//  Extension + NSMutableAttributedString.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 22.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

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
