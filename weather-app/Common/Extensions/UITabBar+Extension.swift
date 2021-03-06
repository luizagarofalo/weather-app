//
//  UITabBar+Extension.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import UIKit

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        let screenSize = UIScreen.main.bounds.height
        sizeThatFits.height = screenSize < 668 ? 80 : 100
        return sizeThatFits
    }
}
