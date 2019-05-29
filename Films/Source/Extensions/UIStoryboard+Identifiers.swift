//
//  UIStoryboard+Identifiers.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UIStoryboard

// MARK: - Storyboard Conformance
extension UIStoryboard {
    enum Storyboard: String {
        
        // MARK: - Screens
        case movies = "Movies"
        
        // MARK: - Components
        case nestedCollection = "CRANestedCollection"
    }
}

// MARK: - Convenience Initializers
extension UIStoryboard {
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
}

// MARK: - Class Functions
extension UIStoryboard {
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
}
