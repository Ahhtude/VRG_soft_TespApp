//
//  CoreDataManager.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 22.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

fileprivate struct Constants {
    static let app = UIApplication.shared.delegate as! AppDelegate
    static let context = app.persistentContainer.viewContext
    static let entity = NSEntityDescription.entity(forEntityName: "News", in: context)
}
class CoreDataManager {
    
    static func addData(post: NewsFeed) {
        let news = NSManagedObject(entity: Constants.entity!, insertInto: Constants.context)
        news.setValue(post.title, forKey: "title")
        news.setValue(post.body, forKey: "body")
        news.setValue(post.publishDate, forKey: "publishDate")
        news.setValue(post.more, forKey: "more")
        
        if let imgString = post.image {
            news.setValue(imgString, forKey: "image")
        }
        
        do {
            try Constants.context.save()
            print("Content to local was saved")
          } catch {
            print("Failed saving")
        }
    }
    
    private func checkBeforeSave(news: NSManagedObject) -> Bool {
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
