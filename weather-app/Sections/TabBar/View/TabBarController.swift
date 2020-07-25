//
//  TabBarController.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if UIDevice().hasNotch {
            if let items = tabBar.items {
                for item in items {
                    item.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.cgColor
        layer.path = UIBezierPath(roundedRect: CGRect(x: 20, y: self.tabBar.bounds.minY + 16, width: self.tabBar.bounds.width - 40,
                                                      height: self.tabBar.bounds.height - 40), cornerRadius: 36).cgPath
        
        self.tabBar.barTintColor = UIColor(red: 24/255, green: 32/255, blue: 242/255, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 24/255, green: 32/255, blue: 242/255, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor(red: 24/255, green: 32/255, blue: 242/255, alpha: 0.50)

        self.tabBar.itemWidth = 50
        self.tabBar.itemPositioning = .centered
        self.tabBar.isTranslucent = false
        self.tabBar.layer.insertSublayer(layer, at: 0)
        self.delegate = self
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.dismiss(animated: false)
        
        guard let navigation = (viewController as? UINavigationController),
            let controller = navigation.viewControllers.first else {
                return
        }
        
        navigation.popToViewController(controller, animated: false)
    }
}
