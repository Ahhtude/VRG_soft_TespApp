//
//  NewsFeedViewProtocols.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

enum CurrentControllerState : String {
    case mostShared  = "/shared/"
    case mostViewed   = "/viewed/"
    case mostEmailed = "/emailed/"
}

protocol NewsFeedViewProtocol: class {
    func showNews(news: [NewsFeed])
    func showError(error: Error?)
    func showLoadingView()
    func hideLoadingView()
}

protocol NewsFeedToPresenterProtocol: class {
    var view: NewsFeedViewProtocol? {get set}
    var interector: PresentorToInterectorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchNewsFeed()
    func viewDidLoad()
    func showPostDetail(from: NewsFeedViewProtocol, forPost: NewsFeed)
    func showFavoriteDetail(from: NewsFeedViewProtocol)
}

protocol PresenterToRouterProtocol: class {
    static func createModule(newsTypeVC: CurrentControllerState) -> UIViewController
           func seguePostDetailModule(from view: NewsFeedViewProtocol, forPost: NewsFeed)
           func segueFavoriteDetailModule(from: NewsFeedViewProtocol)
            
}
