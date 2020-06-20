//
//  NewsDetailRouter.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit

class NewsPostDetailRouter: NewsDetailRoutProtocol {
    
    class func createPostDetailModule(forPost post: NewsFeed) -> UIViewController {

        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PostDetailController")
        
        if let viewController = viewController as? NewsDetailViewController {
            let presenter: NewsDetailPresenterProtocol = NewsDetailPresenter()

            viewController.presenter = presenter
            presenter.view = viewController
            presenter.post = post

            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
