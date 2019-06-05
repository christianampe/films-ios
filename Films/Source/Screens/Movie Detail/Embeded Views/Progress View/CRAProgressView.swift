//
//  CRADetailProgressView.swift
//  Places
//
//  Created by Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

final class CRAProgressView: UIStackView {
    var selectedColor = UIColor(white: 1, alpha: 0.9)
    var unselectedColor = UIColor(white: 1, alpha: 0.3)
    var nextIndex: Int = 0
}

// MARK: - Lifecycle
extension CRAProgressView {
    override func awakeFromNib() {
        super.awakeFromNib()
        unhighlight(at: 0)
    }
}

// MARK: - Public API
extension CRAProgressView {
    func unhighlight(at index: Int) {
        guard index != nextIndex else {
            return
        }
        
        guard let currentView = subviews[safe: index] else {
            return
        }
        
        guard let nextView = subviews[safe: nextIndex] else {
            return
        }
        
        currentView.backgroundColor = unselectedColor
        nextView.backgroundColor = selectedColor
    }
    
    func setNumberOfIncrements(_ count: Int) {
        for i in 0..<count {
            let subview = UIView()
            if i == 0 {
                subview.backgroundColor = selectedColor
            } else {
                subview.backgroundColor = unselectedColor
            }
            
            addArrangedSubview(subview)
        }
    }
}
