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
    @IBOutlet weak var favoriteButton: addToFavoriteButton!
    
    lazy private var newsFeed : NewsFeed? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favoriteButton.setTitleWithImage(title: "add to favorite", image: "favorite")
    }
    
    override func prepareForReuse() {
        feedImage.image = nil
        titleLabel.text = ""
        descrLabel.text = ""
        favoriteButton.isSelect = false
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
        guard let news = self.newsFeed, !self.favoriteButton.isSelect else {
            print("Adding to favorite was failed - news is NIL or News was added")
            return
        }
        
        self.favoriteButton.isSelect = true
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
        news.setValue(post.more, forKey: "more")
        
        if let imgString = post.image {
            news.setValue(imgString, forKey: "image")
        }
        
        if checkBeforeSave(news: news) {
            do {
               try context.save()
                print("Content to local was saved")
              } catch {
                print("Failed saving")
            }
        } else {
            print("News already saved")
            return }
    }
    
    private func checkBeforeSave(news: NSManagedObject) -> Bool {
        print("news \(news)")
        let checker = news as! News
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
                       request.returnsObjectsAsFaults = false
        
         do {
            let result = try context.fetch(request)
            let data = result as! [News]
            if !data.contains(checker) {
                print("data contains \(data.contains(checker))")
                return true
            } else {
                return false
            }
         } catch{
            return false
        }
    }
}


