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
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = " MMMM d, HH:mm"
        return formatter
    }()

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy private var newsFeed : NewsFeed? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        feedImage.image = nil
        titleLabel.text = ""
        descrLabel.text = ""
    }
    
    func fill(post: NewsFeed) {
        self.newsFeed = post
        titleLabel.text = post.title
        descrLabel.text = post.body
        dateLabel.text = post.publishDate
        
        //guard let imgString = post.media.first?.mediaFiles.last?.imgString else {
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
        guard let news = self.newsFeed else{
            print("Adding to favorite was failed - news is NIL")
            return
        }
        self.addToFavorite(post: news)
    }
    
    private func addToFavorite(post: NewsFeed) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "News", in: context)
        let news = NSManagedObject(entity: entity!, insertInto: context)
        news.setValue(post.title, forKey: "title")
        news.setValue(post.body, forKey: "body")
        news.setValue(post.publishDate, forKey: "publishDate")
        //if let imgString = post.media.first?.mediaFiles.last?.imgString{
        if let imgString = post.image{
            news.setValue(imgString, forKey: "image")
        }
        do {
           try context.save()
            print("Content was saved")
          } catch {
           print("Failed saving")
        }
    }
}
