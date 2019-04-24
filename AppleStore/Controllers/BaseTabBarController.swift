//
//  BaseTabBarController.swift
//  AppleStore
//
//  Created by 豊岡正紘 on 2019/04/18.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            createNavController(viewController: AppsPageController(), title: "Apps", imageName: "apps"),
            createNavController(viewController: AppsSearchViewController(), title: "Search", imageName: "search")
        ]
    }
    
    
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.title = title
        
        return navController
    }
}
