//
//  FeedViewCell.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreData

class FeedViewCell: UITableViewCell {

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteButton: AddToFavoriteButton!
    
    lazy private var newsFeed : NewsFeed? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favoriteButton.setTitleWithImage(title: "add to favorite", image: "favorite")
    }
    
    override func prepareForReuse() {
        feedImage.image = nil
        titleLabel.text = ""
        descrLabel.text = ""
        self.newsFeed = nil
    }
    
    func fill(post: NewsFeed) {
        self.newsFeed = post
        titleLabel.text = post.title
        descrLabel.text = post.body
        dateLabel.text = post.publishDate
        
        guard let imgString = post.image else {
            self.feedImage.contentMode = .scaleAspectFit
            self.feedImage.image = UIImage(named: "defaultNewsImage")
            return
        }
        
        if let imageURL = URL(string: imgString) {
            self.feedImage.af_setImage(withURL: imageURL)
        }
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        guard let news = self.newsFeed else {
            print("Adding to favorite was failed - news is NIL")
            return
        }
        
        self.favoriteButton.showSelection()
        CoreDataManager.addData(post: news)
        //self.addToFavorite(post: news)
    }
}


