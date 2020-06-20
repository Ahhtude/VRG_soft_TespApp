//
//  NewsDetailPresenter.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation


class NewsDetailPresenter: NewsDetailPresenterProtocol {
    
weak var view: NewsDetailViewProtocol?
    var post: NewsFeed?
    
    func updateView() {
        view?.showPostDetail(forPost: post!)
    }
}
