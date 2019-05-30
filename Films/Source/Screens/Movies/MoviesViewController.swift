//
//  MoviesViewController.swift
//  Films
//
//  Created Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

struct Movie: CRANestedCollectionViewItem {
    let backgroundImageURLString: String
}

final class MoviesViewController: UIViewController, MoviesViewProtocol {
    var input: MoviesInputProtocol?
    var viewModel: MoviesViewModelProtocol?
    var output: MoviesOutputProtocol?
    var presenter: MoviesPresenterProtocol?
    weak var delegate: MoviesDelegateProtocol?
    
    private var nestedCollection: CRANestedCollectionViewController?
    private lazy var navigationDropdown = CRANavigationDropdownViewController(self)
    @IBAction func didPress(_ sender: Any) {
        navigationDropdown.show()
    }
}

// MARK: - Lifecycle
extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDropdown.set(["Hello", "This", "Is", "A", "Test"])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueCase(for: segue) {
        case .embedNestedCollection:
            break
            nestedCollection = segue.viewController()
            nestedCollection.dataSource = self
        }
    }
}

extension MoviesViewController: CRANestedCollectionViewDataSource {
    func numberOfRows(in nestedCollectionViewController: CRANestedCollectionViewController) -> Int {
        return items.count
    }

    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        numberOfItemsInRow row: Int) -> Int {

        return items[row].count
    }

    func nestedCollectionViewController(_ nestedCollectionViewController: CRANestedCollectionViewController,
                                        viewModelAtIndexPath indexPath: IndexPath) -> CRANestedCollectionViewItem {

        return items[indexPath.section][indexPath.item]
    }
}

// MARK: - SegueIdentifiable
extension MoviesViewController: SegueIdentifiable {
    enum Segue: String {
        case embedNestedCollection
    }
}
