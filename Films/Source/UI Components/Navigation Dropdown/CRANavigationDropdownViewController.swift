//
//  CRANavigationDropdown.swift
//  Films
//
//  Created by Christian Ampe on 5/29/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class CRANavigationDropdownViewController: UIViewController {
    private weak var sourceViewController: UIViewController!
    private weak var sourceNavigationController: UINavigationController!
    
    private weak var titleLabel: UILabel!
    private weak var titleImageView: UIImageView!
    private weak var titleStackView: UIStackView!
    
    private var tableView: UITableView!
    
    private var tableViewBottomConstraint: NSLayoutConstraint!
    private var tableViewHeightConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    
    private var isShown: Bool = false
    
    weak var delegate: CRANavigationDropdownDelegate?
    weak var dataSource: CRANavigationDropdownDataSource?
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
        
        // initialize the title label
        let titleLabel = UILabel()
        
        // constrain title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // style title label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        
        // size title label
        titleLabel.sizeToFit()
        
        // initialize the title image view
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "arrow-down"))
        
        // constrain the title image view
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        titleImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        // style the title image view
        titleImageView.contentMode = .scaleAspectFill
        
        // initialize the title stack view
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, titleImageView])
        
        // constrain the title stack view
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // style the title stack view
        titleStackView.axis = .horizontal
        titleStackView.alignment = .center
        titleStackView.distribution = .fill
        titleStackView.spacing = 10
        
        // set the title stack view as the title view of the embeded view controller
        source.navigationItem.titleView = titleStackView
        
        // initialize the table view
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
        
        // add navigation label tap gesture recognizer
        let navigationBarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleNavigationBarTap(_:)))
        sourceNavigationController.navigationBar.addGestureRecognizer(navigationBarTapGestureRecognizer)
        
        // assign self properties
        self.sourceViewController = source
        self.sourceNavigationController = sourceNavigationController
        self.titleLabel = titleLabel
        self.titleImageView = titleImageView
        self.titleStackView = titleStackView
        self.tableView = tableView
    }
}

// MARK: - Public API
extension CRANavigationDropdownViewController {
    func reloadData() {
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
            self.titleImageView.transform = self.titleImageView.transform.rotated(by: 180 * CGFloat(Double.pi/180))
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
            self.titleImageView.transform = self.titleImageView.transform.rotated(by: 180 * CGFloat(Double.pi/180))
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.remove(self.tableView)
            self.remove(self.view)
            self.isShown = false
        })
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
    
    func toggle(_ animated: Bool = true) {
        isShown ? hide(animated) : show(animated)
    }
    
    func set(title: String?) {
        titleLabel.text = title
    }
}

// MARK: - UITableViewDataSource
extension CRANavigationDropdownViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return dataSource?.numberOfRows(in: tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(for: indexPath) as CRANavigationDropdownCell
    }
}

// MARK: - UITableViewDelegate
extension CRANavigationDropdownViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? CRANavigationDropdownCell else {
            assertionFailure("incorrect cell type utilized")
            return
        }
        
        guard let title = dataSource?.tableView(tableView, titleForFilterAtRow: indexPath.row) else {
            return
        }
        
        cell.configure(title)
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        set(title: dataSource?.tableView(tableView,
                                         titleForSelectedFilterAtRow: indexPath.row))
        
        delegate?.tableView(tableView,
                            didSelectFilterAtRow: indexPath.row)
    }
}
