//
//  FavoriteDetailViewProtocol.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit



protocol FavoriteDetailViewProtocol: class {
     func showFavoriveNews(news: [NewsFeed])
}

protocol FavoriteDetailRoutProtocol: class {
    static func createModule() -> UIViewController
    func seguePostDetailModule(from view: FavoriteDetailViewProtocol, forPost: NewsFeed)
    
}

protocol FavoriteDetailToPresenterProtocol: class {
    var view: FavoriteDetailViewProtocol? {get set}
    var interector: PresentorToInterectorProtocol? {get set}
    var router: FavoriteDetailRoutProtocol? {get set}
    func fetchNewsFeed()
    func viewDidLoad()
    func showPostDetail(from view: FavoriteDetailViewProtocol, forPost: NewsFeed)
}
