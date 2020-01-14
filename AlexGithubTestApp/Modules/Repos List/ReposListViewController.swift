//
//  ReposListViewController.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import UIKit

protocol ReposListView: class {
    func set(isLoading: Bool)
    func present(_ data: [ReposListViewData])
    func present(_ error: Error)
}

struct ReposListViewData {
    let name: String
    let ownerName: String
    let ownerImageURL: URL?
}

class ReposListViewController: UIViewController {

    var interactor: ReposListInteractor!
    
    private var data = [ReposListViewData]() {
        didSet { self.tableView.reloadData() }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            // Here we could build the cell UI inside the view controller in the storyboard but I am avoiding this here
            // because that would couple this type of cell to this specific view. If we want to reuse this cell in the
            // future in another view, then we will have to do the work of extracting the UI from the view controller.
            // By using a stand alone xib we can reuse the cell in other view with minimal effort.
            self.tableView.registerNib(RepoTableViewCell.self)
            self.tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.interactor.fetchRepos()
    }
}

//MARK: - ReposListView

extension ReposListViewController: ReposListView {
    
    func set(isLoading: Bool) {
        self.tableView.isHidden = isLoading
        
        isLoading ?
            self.activityIndicator.startAnimating() :
            self.activityIndicator.stopAnimating()
    }
    
    func present(_ data: [ReposListViewData]) {
        self.data = data
    }
    
    func present(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource

extension ReposListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(RepoTableViewCell.self, at: indexPath)
        cell.configure(with: data[indexPath.row])
        return cell
    }
}
