//
//  addToFavoriteButton.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

class AddToFavoriteButton : UIButton {
        override func awakeFromNib() {
            super.awakeFromNib()
            titleLabel?.numberOfLines = 0
            layer.borderColor = UIColor.black.cgColor
            layer.cornerRadius = 6
            backgroundColor = .gray
            layer.borderWidth = 0.5
        }
        
        func showSelection() {
            UIView.animate(withDuration: 0.3, animations: {[unowned self] in
                    self.backgroundColor = UIColor.red
                }, completion: {[unowned self] _ in
                    UIView.animate(withDuration: 0.3 , animations: {[unowned self] in
                       self.backgroundColor = UIColor.gray
                    })
                })
        }
    
    func setTitleWithImage(title: String, image: String) {
        guard let img = UIImage(named: image) else {
            self.setAttributedTitle(NSAttributedString(string: title), for: .normal)
            return
        }
        let imageAttach = NSTextAttachment()
        imageAttach.bounds = CGRect(x: 0, y: -3, width: img.size.width, height: img.size.width)
        imageAttach.image = img
        let main = NSMutableAttributedString(attachment: imageAttach)
        let title = NSAttributedString(string: "  " + NSLocalizedString(title, comment: "") + " ",
                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)])
        main.append(title)
        self.setAttributedTitle(main, for: .normal)
    }
}
