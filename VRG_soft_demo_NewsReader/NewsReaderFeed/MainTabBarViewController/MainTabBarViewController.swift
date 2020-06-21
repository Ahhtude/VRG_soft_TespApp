//
//  MainTabBarViewController.swift
//  VRG_soft_demo_NewsReader
//
//  Created by Sergey berdnik on 21.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarViewController : UITabBarController{
    var firstVC = NewsFeedRouter.createModule(newsTypeVC: CurrentControllerState.mostViewed)
    var secondVC = NewsFeedRouter.createModule(newsTypeVC: CurrentControllerState.mostShared)
    var thredVC = NewsFeedRouter.createModule(newsTypeVC: CurrentControllerState.mostEmailed)

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setToolbarItems(self.buttons, animated: true)
        self.setViewControllers([firstVC,secondVC,thredVC], animated: true)
        
        
    }
}
