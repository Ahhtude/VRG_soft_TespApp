//
//  Pagination + Interactor protocols.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation

protocol InterectorToPresenterProtocol: class {
    func newsFetched(news: [NewsFeed])
    func newsFetchedFailed(error: Error?)
}

protocol PresentorToInterectorProtocol: class {
    var presenter: InterectorToPresenterProtocol? {get set}
    var remoteDatamanager: NewsFeedListRemoteDataManagerProtocol? {get set}
    func fetchNewsFeed()
    var currentNewsState: CurrentControllerState {get set}
}
