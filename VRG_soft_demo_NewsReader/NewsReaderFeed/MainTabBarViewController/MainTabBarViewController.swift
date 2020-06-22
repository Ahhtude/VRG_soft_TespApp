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
    var firstVC = NewsFeedRouter.createModuleViewdVC()
    var secondVC = NewsFeedRouter.createModuleMailedVC()
    var thirdVC = NewsFeedRouter.createModuleSharedVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([firstVC,secondVC,thirdVC], animated: true)
        setUpBar()
    }
    
    private func setUpBar(){
        firstVC.tabBarItem.title = "Most viewed"
        firstVC.tabBarItem.image = UIImage(named: "viewed")
        firstVC.tabBarItem.selectedImage = UIImage(named: "viewed")
        
        secondVC.tabBarItem.title = "Most mailed"
        secondVC.tabBarItem.image = UIImage(named: "emailed")
        secondVC.tabBarItem.selectedImage = UIImage(named: "emailed")
        
        thirdVC.tabBarItem.title = "Most shared"
        thirdVC.tabBarItem.image = UIImage(named: "shared")
        thirdVC.tabBarItem.selectedImage = UIImage(named: "shared")
        
    }
}
