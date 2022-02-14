//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by Роман on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import CoreData

final class LikedPostsViewController: UIViewController {
    var viewModel: LikedPostsViewModel
    
    private var tableView = UITableView()
    private let cellId = "reusableCell"
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show all posts", style: .plain, target: self, action: #selector(undoSortingLikedPosts))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort by author", style: .plain, target: self, action: #selector(sortLikedPost))
    }
    
    @objc func sortLikedPost() {
        let alertController = UIAlertController(title: "Preferred author", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter author's name"
        }
        let sortAction = UIAlertAction(title: "Sort posts", style: .default) { [weak self] action in
            guard let self = self else { return }
            let textField = alertController.textFields![0]
            guard let enteredText = textField.text else { return }
            self.viewModel.onDataChanged?(enteredText)
            self.tableView.reloadData()
        }
        alertController.addAction(sortAction)
        self.present(alertController, animated: true) {
        }
    }
    
    @objc func undoSortingLikedPosts() {
     fetchAndReloadPosts()
    }
        
    func fetchAndReloadPosts() {
        viewModel.model.likedPosts = coreDataStack.fetchLikedPosts()
        print(viewModel.model.likedPosts)
        tableView.reloadData()
    }
    
    init(viewModel: LikedPostsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchAndReloadPosts()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LikedPostTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.onAutoLayout()
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        viewModel.presentAlertVC = { [weak self] title, message, actionTitle in
            guard let self = self else { return }
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let userTapToContinue = UIAlertAction(title: actionTitle, style: .default)
            alertController.addAction(userTapToContinue)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension LikedPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.likedPosts.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LikedPostTableViewCell
        cell.likedPost = viewModel.model.likedPosts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete post") { [weak self] action, view, completionHandler in
            guard let self = self else { return }
            coreDataStack.remove(likedPost: self.viewModel.model.likedPosts[indexPath.row])
            self.fetchAndReloadPosts()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "minus.circle.fill")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
