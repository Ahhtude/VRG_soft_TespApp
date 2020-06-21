//
//  FavoriteDetailPresenter.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation


class FavoriteDetailPresenter: FavoriteDetailToPresenterProtocol {
    var view: FavoriteDetailViewProtocol?
    var interector: PresentorToInterectorProtocol?
    var router: FavoriteDetailRoutProtocol?
    
    func fetchNewsFeed() {
        interector?.fetchNewsFeed()
    }
    
    func showPostDetail(from view: FavoriteDetailViewProtocol, forPost post: NewsFeed) {
        router?.seguePostDetailModule(from: view, forPost: post)
    }
}

extension FavoriteDetailPresenter: InterectorToPresenterProtocol {
    
    func viewDidLoad() {
        interector?.fetchNewsFeed()
    }
    
    func newsFetched(news: [NewsFeed]) {
        view?.showFavoriveNews(news: news)
    }
    
    func newsFetchedFailed(error: Error?) {
        print("")
    }
}

