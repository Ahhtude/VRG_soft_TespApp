//
//  FavoriteViewCell.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit
import AlamofireImage

class FavoriteViewCell: UITableViewCell {
    
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = UIColor.mainAppColor
    }
    
    override func prepareForReuse() {
        feedImage.image = nil
        titleLabel.text = ""
        descrLabel.text = ""
    }
    
        func fill(post: NewsFeed) {
            titleLabel.text = post.title
            descrLabel.text = post.body
            
        guard let imgString = post.image else {
                   self.feedImage.contentMode = .scaleAspectFit
                   self.feedImage.image = UIImage(named: "defaultNewsImage")
                   return
               }
        
        if let imageURL = URL(string: imgString) {
                   self.feedImage.af_setImage(withURL: imageURL)
               }
        }
}
