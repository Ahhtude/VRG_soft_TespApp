//
//  NewsFeedViewProtocols.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

protocol NewsFeedViewProtocol: class {
    func showNews(news: [NewsFeed])
    func showError(error: Error?)
    func showLoadingView()
    func hideLoadingView()
}

protocol InterectorToPresenterProtocol: class {
    func newsFetched(news: [NewsFeed])
    func newsFetchedFailed(error: Error?)
}

protocol PresentorToInterectorProtocol: class {
    var presenter: InterectorToPresenterProtocol? {get set}
    var remoteDatamanager: NewsFeedListRemoteDataManagerProtocol? {get set}
    func fetchNewsFeed()
}

protocol NewsFeedToPresenterProtocol: class {
    var view: NewsFeedViewProtocol? {get set}
    var interector: PresentorToInterectorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    
    func fetchNewsFeed()
    func viewDidLoad()
    func showPostDetail(from: NewsFeedViewProtocol, forPost: NewsFeed)
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
           func seguePostDetailModule(from: NewsFeedViewProtocol, forPost: NewsFeed)
}
