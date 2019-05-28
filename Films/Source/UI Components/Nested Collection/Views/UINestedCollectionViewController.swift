//
//  UINestedCollectionViewController.swift
//  Films
//
//  Created by Christian Ampe on 5/13/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol UINestedCollectionViewDataSource: class {
    func numberOfRows(in tableView: UITableView) -> Int
    
    func tableView(_ tableView: UITableView,
                   viewModelsFor row: Int) -> [UINestedCollectionViewRowCellViewModelProtocol]
    
    func tableView(_ tableView: UITableView,
                   titleFor row: Int) -> String
}

protocol UINestedCollectionViewDelegate: class {
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView,
                   didSelectItemAt indexPath: IndexPath)
}

extension UINestedCollectionViewDelegate {
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath) {}
    
    func tableView(_ tableView: UITableView,
                   didSelectItemAt indexPath: IndexPath) {}
}

class UINestedCollectionViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    weak var delegate: UINestedCollectionViewDelegate?
    weak var dataSource: UINestedCollectionViewDataSource?
    
    var currentIndexPath = IndexPath(item: 0, section: 0)
}

// MARK: - Public API
extension UINestedCollectionViewController {
    func reloadData() {
        tableView.reloadData()
    }
    
    func focus(indexPath: IndexPath) {
        let requestedTableViewIndexPath = IndexPath(row: 0, section: indexPath.section)
        tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.section), at: .top, animated: true)
        
        // TODO: inspect bug where this fails despite a valid index path
        guard let cell = tableView.cellForRow(at: requestedTableViewIndexPath) as? UINestedCollectionViewItemCell else {
            return
        }
        
        cell.focus(index: indexPath.row)
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
}

// MARK: - UITableViewDataSource
extension UINestedCollectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfRows(in: tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewItemCell
        
        guard let viewModels = dataSource?.tableView(tableView, viewModelsFor: indexPath.section) else {
            return cell
        }
        
        cell.set(properties: viewModels)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        return dataSource?.tableView(tableView,
                                     titleFor: section)
    }
}

// MARK: - UITableViewDelegate
extension UINestedCollectionViewController: UITableViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        targetContentOffset.pointee.y = nextFocus(for: scrollView, withVelocity: velocity).offset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = nextFocus(for: scrollView).index
        
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: index)) as? UINestedCollectionViewItemCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        currentIndexPath.row = cell.currentItemIndex
        currentIndexPath.section = index
        
        delegate?.tableView(tableView,
                            didDisplayItemAt: currentIndexPath)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = nextFocus(for: scrollView).index
        
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: index)) as? UINestedCollectionViewItemCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        currentIndexPath.row = cell.currentItemIndex
        currentIndexPath.section = index
        
        delegate?.tableView(tableView,
                            didDisplayItemAt: currentIndexPath)
    }
}

// MARK: - UINestedCollectionViewColumnCellDelegate
extension UINestedCollectionViewController: UINestedCollectionViewItemCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didDisplayCellAt index: Int) {
        
        currentIndexPath.row = index
        
        delegate?.tableView(tableView,
                            didDisplayItemAt: currentIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt index: Int) {
        
        delegate?.tableView(tableView,
                            didSelectItemAt: IndexPath(item: index,
                                                       section: currentIndexPath.section))
    }
}

// MARK: - Set Up Methods
private extension UINestedCollectionViewController {
    func setUpTableView() {
        tableView.decelerationRate = .fast
        tableView.sectionHeaderHeight = UINestedCollectionViewController.headerHeight
        tableView.rowHeight = UINestedCollectionViewController.rowHeight
        tableView.sectionFooterHeight = UINestedCollectionViewController.footerHeight
    }
}

// MARK: - Helper Methods
private extension UINestedCollectionViewController {
    func nextFocus(for scrollView: UIScrollView,
                   withVelocity velocity: CGPoint = .zero) -> (index: Int, offset: CGFloat) {
        
        let verticalVelocity = velocity.y
        let rowHeight = UINestedCollectionViewController.cellHeight
        
        var itemIndex = round(scrollView.contentOffset.y / rowHeight)
        
        if verticalVelocity > 0 {
            itemIndex += 1
        } else if verticalVelocity < 0 {
            itemIndex -= 1
        }
        
        return (index: correctedIndex(for: Int(itemIndex)), offset: itemIndex * rowHeight)
    }
    
    func correctedIndex(for index: Int) -> Int {
        guard index > 0 else {
            return 0
        }
        
        guard let dataSource = dataSource else {
            assertionFailure("how did you get this far")
            return 0
        }
        
        let maxRowIndex = dataSource.numberOfRows(in: tableView) - 1
        
        guard index < maxRowIndex else {
            return maxRowIndex
        }
        
        return index
    }
}

// MARK: - Static Properties
extension UINestedCollectionViewController {
    static let headerHeight: CGFloat = UIScreen.main.bounds.height * 0.05
    static let rowHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    static let footerHeight: CGFloat = 0.0
    static let cellHeight: CGFloat =
        UINestedCollectionViewController.rowHeight +
        UINestedCollectionViewController.headerHeight +
        UINestedCollectionViewController.footerHeight
}
