//
//  NewsFeedRouter.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 20.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

class NewsFeedRouter: PresenterToRouterProtocol {
    
    func seguePostDetailModule(from view: NewsFeedViewProtocol, forPost post: NewsFeed) {
        
        let postDetailViewController = NewsPostDetailRouter.createPostDetailModule(forPost: post)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
    
    func segueFavoriteDetailModule(from view: NewsFeedViewProtocol) {
        let favoriteDetailViewController = FavoriteDetailRouter.createModule()
    
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(favoriteDetailViewController, animated: true)
        }
    }
    
    static func createModule(newsTypeVC: CurrentControllerState) -> UIViewController {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "NewsFeedViewControoler") as? NewsFeedViewController
        
        let presenter: NewsFeedToPresenterProtocol & InterectorToPresenterProtocol = NewsFeedPresenter()
        
        let interactor: PresentorToInterectorProtocol = NewsFeedInterector(newsInterectorType: newsTypeVC)

        let router: PresenterToRouterProtocol = NewsFeedRouter()
        
        viewController?.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = NewsFeedListRemoteDataManager()
        return UINavigationController.init(rootViewController: viewController!)
    }
    
    static func createModuleViewdVC() -> UIViewController {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "ViewdFeedViewController") as? ViewdFeedViewController
        
        let presenter: NewsFeedToPresenterProtocol & InterectorToPresenterProtocol = NewsFeedPresenter()
        
        let interactor: PresentorToInterectorProtocol = NewsFeedInterector(newsInterectorType: CurrentControllerState.mostViewed)

        let router: PresenterToRouterProtocol = NewsFeedRouter()
        
        viewController?.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = NewsFeedListRemoteDataManager()
        return UINavigationController.init(rootViewController: viewController!)
        
    }
    
    static func createModuleMailedVC() -> UIViewController {
        
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "MailedFeedViewController") as? MailedFeedViewController
        
        let presenter: NewsFeedToPresenterProtocol & InterectorToPresenterProtocol = NewsFeedPresenter()
        
        let interactor: PresentorToInterectorProtocol = NewsFeedInterector(newsInterectorType: CurrentControllerState.mostEmailed)

        let router: PresenterToRouterProtocol = NewsFeedRouter()
        
        viewController?.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = NewsFeedListRemoteDataManager()
        return UINavigationController.init(rootViewController: viewController!)
    }
    
    static func createModuleSharedVC() -> UIViewController {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "SharedFeedViewController") as? SharedFeedViewController
        
        let presenter: NewsFeedToPresenterProtocol & InterectorToPresenterProtocol = NewsFeedPresenter()
        
        let interactor: PresentorToInterectorProtocol = NewsFeedInterector(newsInterectorType: CurrentControllerState.mostShared)

        let router: PresenterToRouterProtocol = NewsFeedRouter()
        
        viewController?.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = NewsFeedListRemoteDataManager()
        return UINavigationController.init(rootViewController: viewController!)
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
