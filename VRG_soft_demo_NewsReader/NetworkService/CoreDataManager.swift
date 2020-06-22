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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        request.returnsObjectsAsFaults = false
        do {
            let result = try Constants.context.fetch(request)
            
            guard let data = result as? [News],!data.map({$0.title}).contains(post.title)
        
                else {
                    print("adding news to core data failed")
                    return
            }
            
                    let news = NSManagedObject(entity: Constants.entity!, insertInto: Constants.context)
                    news.setValue(post.title, forKey: "title")
                    news.setValue(post.body, forKey: "body")
                    news.setValue(post.publishDate, forKey: "publishDate")
                    news.setValue(post.more, forKey: "more")
                    if let imgString = post.image {
                        news.setValue(imgString, forKey: "image")
                    }
                    try Constants.context.save()
 }
        catch {
                    print("Failed saving")
                }
}
}
