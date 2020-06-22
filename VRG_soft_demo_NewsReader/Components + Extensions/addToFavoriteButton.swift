//
//  addToFavoriteButton.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

class addToFavoriteButton : UIButton {
        var isSelect: Bool = false {
            didSet {
                isSelected = isSelect
                selected(selected: isSelect)
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.titleLabel?.numberOfLines = 0
            layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = 6
            layer.borderWidth = 1
        }
        
        func selected(selected: Bool) {
            if selected {
                backgroundColor = UIColor.red
            } else {
                backgroundColor = UIColor.white
            }
        }
    
    func setTitleWithImage(title: String, image: String) {
        guard let img = UIImage(named: image) else {
            self.setAttributedTitle(NSAttributedString(string: title), for: .normal)
            return
        }
        let imageAttach = NSTextAttachment()
        imageAttach.bounds = CGRect(x: 5, y: 0, width: img.size.width, height: img.size.width)
        imageAttach.image = img
        let main = NSMutableAttributedString(attachment: imageAttach)
        let title = NSAttributedString(string: "  " + NSLocalizedString(title, comment: "") + " ",
                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)])
        main.append(title)
        self.setAttributedTitle(main, for: .normal)
    }
}
