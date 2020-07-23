//
//  UIView+Extension.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 23/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func fromNib<T: UIView>(owner: Any? = nil) -> T {
        guard let result = Bundle.main.loadNibNamed(T.identifier, owner: owner, options: nil)?.first as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        
        return result
    }
}
