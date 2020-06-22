//
//  FeedInterector.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import Alamofire

class Pagination {
   private var currentPage: Int
   private var maxCount: Int
    
    init() {
        currentPage = 1
        maxCount = 1
    }
    
    func increment() {
        currentPage += 1
    }
    
    func getCurrentPage() -> Int {
        return currentPage
    }

    func reset() {
        currentPage = 1
    }
}

class NewsFeedInterector: PresentorToInterectorProtocol {
    
    var presenter: InterectorToPresenterProtocol?
    var remoteDatamanager: NewsFeedListRemoteDataManagerProtocol?
    
    var currentNewsState: CurrentControllerState
    
    init(newsInterectorType: CurrentControllerState) {
        self.currentNewsState = newsInterectorType
    }
    
   private var pagination = Pagination()
   private var dataSource: [NewsFeed] = []
    private var isLoading: Bool = false
    
    func fetchNewsFeed() {
        if isLoading {
            return
        }
        
        isLoading = true
        remoteDatamanager?.getNews(type: currentNewsState, resultHandler: {[weak self] (result) in
            self?.isLoading = false
            self?.dataSource.append(contentsOf: result)
            self?.pagination.increment()
            self?.presenter?.newsFetched(news: self?.dataSource ?? [])
        }, errorHandler: {[weak self] (error) in
            self?.isLoading = false
            self?.presenter?.newsFetchedFailed(error: error)
        })
    }
}

