//
//  FavoriteDetailRouter.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit

class FavoriteDetailRouter: FavoriteDetailRoutProtocol {
    
    class func createModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "FavoriteDetailViewController")
        
        let presenter: FavoriteDetailToPresenterProtocol & InterectorToPresenterProtocol = FavoriteDetailPresenter()
        let interactor: PresentorToInterectorProtocol = FavoriteFeedInterector()
        let router: FavoriteDetailRoutProtocol = FavoriteDetailRouter()
        
        if let viewController = viewController as? FavoriteDetailViewController {

            viewController.presenter = presenter
            presenter.view = viewController
            presenter.router = router
            presenter.interector = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = NewsFeedListRemoteDataManager()
            return viewController
        }
        return UIViewController()
    }
    
    func seguePostDetailModule(from view: FavoriteDetailViewProtocol, forPost post: NewsFeed) {
        
        let postDetailViewController = NewsPostDetailRouter.createPostDetailModule(forPost: post)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
