//
//  FavoriteFeedInterector.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

class FavoriteFeedInterector: PresentorToInterectorProtocol {
    var presenter: InterectorToPresenterProtocol?
    var remoteDatamanager: NewsFeedListRemoteDataManagerProtocol?
    
    var currentNewsState: CurrentControllerState = CurrentControllerState.mostEmailed
    
   private var pagination = Pagination()
   private var dataSource: [NewsFeed] = []
   private var isLoading: Bool = false
    
    func fetchNewsFeed() {
        self.dataSource.removeAll()
        if isLoading {
            return
        }
        
        isLoading = true
        remoteDatamanager?.getFavorite(pagination: pagination, resultHandler: {[weak self] (result) in
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
