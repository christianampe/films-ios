//
//  CRANavigationDropdownCell.swift
//  Films
//
//  Created by Christian Ampe on 5/29/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class CRANavigationDropdownCell: UITableViewCell {
    private var label: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // configure cell
        backgroundColor = .clear
        
        // construct label
        let label = UILabel(frame: .zero)
        
        // add label to subview
        addSubview(label)
        
        // configure label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // constrain label
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        // style label
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        
        // assign self properties
        self.label = label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CRANavigationDropdownCell {
    func configure(_ item: String) {
        label.text = item
    }
}
