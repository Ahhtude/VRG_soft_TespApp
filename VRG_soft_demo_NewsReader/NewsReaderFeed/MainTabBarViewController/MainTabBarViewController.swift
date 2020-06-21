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
    
//    let buttons = [UIBarButtonItem(image: UIImage(named: "viewed"), style: .done, target: self, action: nil),
//                   UIBarButtonItem(image: UIImage(named: "shared"), style: .done, target: self, action: nil),
//                  UIBarButtonItem(image: UIImage(named: "emailed"), style: .done, target: self, action: nil)]
        
//        [UIBarButtonItem(title: "most viewd", image: UIImage(named: "viewed"), tag: 0),
//                UITabBarItem(title: "most shared", image: UIImage(named: "shared"), tag: 1),
//                UITabBarItem(title: "most emailed", image: UIImage(named: "emailed"), tag: 2)]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setToolbarItems(self.buttons, animated: true)
        self.setViewControllers([firstVC,secondVC,thredVC], animated: true)
        
        
    }
}
