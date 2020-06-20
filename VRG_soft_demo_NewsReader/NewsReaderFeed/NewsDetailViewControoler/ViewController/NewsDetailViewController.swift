//
//  NewsDetailViewController.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit
import Alamofire

class NewsDetailViewController: BaseViewController, NewsDetailViewProtocol {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    var presenter: NewsDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
        self.title = "Post"
    }
    
    func showPostDetail(forPost post: NewsFeed) {
        if let imageURL = URL(string: post.media.mediaFiles[0].imgString) {
            self.postImage.af_setImage(withURL: imageURL)
        }
        
        titleLabel.text = post.title
        descrLabel.text = post.body
        
        if let data = post.publishDate {
            dateLabel.text = "Updated: \(FeedViewCell.dateFormatter.string(from: data))"
        }
    }
}
