//
//  CRANavigationDropdown.swift
//  Films
//
//  Created by Christian Ampe on 5/29/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class CRANavigationDropdownViewController: UIViewController {
    private var tableView: UITableView!
    private weak var sourceNavigationController: UINavigationController!
    
    private var tableViewBottomConstraint: NSLayoutConstraint!
    private var tableViewHeightConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    
    private var isShown: Bool = false
    private var items: [String] = []
}

// MARK: - Initializers
extension CRANavigationDropdownViewController {
    convenience init(_ source: UIViewController) {
        self.init()
        
        // ensure there is a navigation controller from the source
        guard let sourceNavigationController = source.navigationController else {
            assertionFailure("source must be embedded in a navigation controller")
            return
        }
        
        // construct the table view
        let tableView = UITableView(frame: .zero)
        
        // configure the table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerTableViewCell(cell: CRANavigationDropdownCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // style the table view
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.90)
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        // configure the view
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // configure the navigation bar
        sourceNavigationController.navigationBar.tintColor = .black
        sourceNavigationController.navigationBar.barTintColor = .black
        sourceNavigationController.navigationBar.isTranslucent = false
        
        // add navigation label tap gesture recognizer
        let navigationBarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleNavigationBarTap(_:)))
        sourceNavigationController.navigationBar.addGestureRecognizer(navigationBarTapGestureRecognizer)
        
        let backgroundViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundViewTap(_:)))
        view.addGestureRecognizer(backgroundViewTapGestureRecognizer)

        // assign self properties
        self.tableView = tableView
        self.sourceNavigationController = sourceNavigationController
    }
}

private extension CRANavigationDropdownViewController {
    @objc func handleNavigationBarTap(_ sender: UITapGestureRecognizer) {
        
        // get the view which was touched
        let location = sender.location(in: sourceNavigationController.navigationBar)
        let hitView = sourceNavigationController.navigationBar.hitTest(location, with: nil)
        
        // if the view is a control abort
        guard !(hitView is UIControl) else {
            return
        }
        
        toggle()
    }
    
    @objc func handleBackgroundViewTap(_ sender: UITapGestureRecognizer) {
        hide()
    }
}

// MARK: - Public API
extension CRANavigationDropdownViewController {
    func set(_ items: [String]) {
        self.items = items
        tableView.reloadData()
    }
    
    func show(_ animated: Bool = true) {
        
        // exit execution if the dropdown is already shown
        guard !isShown else {
            return
        }
        
        // add views to view controller
        add(view, to: sourceNavigationController)
        add(tableView, to: sourceNavigationController)
        
        let tableViewHeight = tableView.contentSize.height
        
        // set appropriate table view height
        tableViewHeightConstraint.constant = tableViewHeight
        
        // layout view
        view.layoutIfNeeded()
        
        // background color to be animated
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        // constraints to be animated
        tableViewBottomConstraint.constant = tableViewHeight
        
        // animate the constraint and the background color to an opaque black
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }, completion: { _ in
            self.isShown = true
        })
    }
    
    func hide(_ animated: Bool = true) {
        
        // exit execution if the dropdown is already hidden
        guard isShown else {
            return
        }
        
        // background color to be animated
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        // shift the bottom of the table view up to the bottom of the navigation bar
        tableViewBottomConstraint.constant = 0
        
        // animate the constraint and the background color to clear
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        }, completion: { _ in
            self.remove(self.tableView)
            self.remove(self.view)
            self.isShown = false
        })
    }
    
    func toggle(_ animated: Bool = true) {
        isShown ? hide(animated) : show(animated)
    }
}

// MARK: - Helper Methods
private extension CRANavigationDropdownViewController {
    func add(_ view: UIView,
             to navigationController: UINavigationController) {
        
        // add view to navigation controller
        sourceNavigationController.view.insertSubview(view, belowSubview: sourceNavigationController.navigationBar)
        
        // avoid the table view from covering the bar
        view.bringSubviewToFront(navigationController.navigationBar)
        
        // constrain the view to the source
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: navigationController.view.bottomAnchor)
        bottomConstraint.isActive = true
        view.topAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: navigationController.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: navigationController.view.rightAnchor).isActive = true
        
        // layout view
        view.layoutIfNeeded()
        
        // set properties
        self.bottomConstraint = bottomConstraint
    }
    
    func add(_ tableView: UITableView,
             to navigationController: UINavigationController) {
        
        // add the table view to the view
        view.addSubview(tableView)
        
        // constrain the table view
        let tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor)
        let tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height)
        tableViewBottomConstraint.isActive = true
        tableViewHeightConstraint.isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // layout table view
        tableView.layoutIfNeeded()
        
        // set properties
        self.tableView = tableView
        self.tableViewBottomConstraint = tableViewBottomConstraint
        self.tableViewHeightConstraint = tableViewHeightConstraint
    }
    
    func remove(_ view: UIView) {
        view.removeFromSuperview()
    }
    
    func remove(_ tableView: UITableView) {
        tableView.removeFromSuperview()
    }
}

// MARK: - UITableViewDataSource
extension CRANavigationDropdownViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as CRANavigationDropdownCell
        cell.configure(items[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CRANavigationDropdownViewController: UITableViewDelegate {}
