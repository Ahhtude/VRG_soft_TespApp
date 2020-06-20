//
//  FeedViewCell.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit
import AlamofireImage

class FeedViewCell: UITableViewCell {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = " MMMM d, HH:mm"
        return formatter
    }()

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        feedImage.image = nil
        titleLabel.text = ""
        descrLabel.text = ""
    }
    
    func fill(post: NewsFeed) {
        if let imageURL = URL(string: post.media.mediaFiles[0].imgString) {
            self.feedImage.af_setImage(withURL: imageURL)
        }
        
        titleLabel.text = post.title
        descrLabel.text = post.body
        
        if let data = post.publishDate {
            dateLabel.text = "Updated: \(FeedViewCell.dateFormatter.string(from: data))"
        }
    }
}
