//
//  NewsDetailViewProtocol.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

protocol NewsDetailViewProtocol: class {
    var presenter: NewsDetailPresenterProtocol? { get set }
    func showPostDetail(forPost post: NewsFeed)
}

protocol NewsDetailRoutProtocol: class {
    static func createPostDetailModule(forPost post: NewsFeed) -> UIViewController
}

protocol NewsDetailPresenterProtocol: class {
    var view: NewsDetailViewProtocol? { get set }
    var post: NewsFeed? { get set }
    func updateView()
}
