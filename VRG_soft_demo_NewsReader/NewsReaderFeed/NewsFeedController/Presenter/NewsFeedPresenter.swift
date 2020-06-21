//
//  NewsFeedPresenter.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

class NewsFeedPresenter: NewsFeedToPresenterProtocol {
    var view: NewsFeedViewProtocol?
    var interector: PresentorToInterectorProtocol?
    var router: PresenterToRouterProtocol?
    

    func fetchNewsFeed() {
        interector?.fetchNewsFeed()
    }

    func showPostDetail(from view: NewsFeedViewProtocol, forPost post: NewsFeed) {
        router?.seguePostDetailModule(from: view, forPost: post)
    }
    
    func showFavoriteDetail(from view: NewsFeedViewProtocol ) {
        router?.segueFavoriteDetailModule(from: view)
    }
    
}

extension NewsFeedPresenter: InterectorToPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoadingView()
        interector?.fetchNewsFeed()
    }
    
    func newsFetched(news: [NewsFeed]) {
        view?.hideLoadingView()
        view?.showNews(news: news)
    }
    
    func newsFetchedFailed(error: Error?) {
        view?.hideLoadingView()
        view?.showError(error: error)
    }
}
