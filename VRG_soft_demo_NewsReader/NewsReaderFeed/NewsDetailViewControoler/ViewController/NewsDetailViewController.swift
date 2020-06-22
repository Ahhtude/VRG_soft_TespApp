//
//  NewsDetailViewController.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit
import Alamofire

fileprivate struct Constants{
    static var moreDetailLabel = "Click for more..."
    static var title = "Post"
}

class NewsDetailViewController: BaseViewController, NewsDetailViewProtocol {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var moreDetail: UITextView!
    
    var presenter: NewsDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
        self.title = Constants.title
    }
    
    
    func showPostDetail(forPost post: NewsFeed) {
        titleLabel.text = post.title
        descrLabel.text = post.body
        dateLabel.text = post.publishDate
        moreDetail.text = Constants.moreDetailLabel
        self.addLinkToTextView(text: post.more)
    
        guard let imgString = post.image else {
                   self.postImage.contentMode = .scaleAspectFit
                   self.postImage.image = UIImage(named: "defaultNewsImage")
                   return
               }
               
         if let imageURL = URL(string: imgString) {
                   self.postImage.af_setImage(withURL: imageURL)
               }
    }
        private func addLinkToTextView(text: String){
            let linkedText = NSMutableAttributedString(attributedString: self.moreDetail.attributedText)
            let hyperlinked = linkedText.setAsLink(textToFind: Constants.moreDetailLabel,
                                                   linkURL: text)

            if hyperlinked {
                self.moreDetail.attributedText = NSAttributedString(attributedString: linkedText)
            }
        }
}
