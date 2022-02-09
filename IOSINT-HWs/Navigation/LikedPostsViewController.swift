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
        
    func fetchAndReloadPosts() {
        viewModel.model.likedPosts = coreDataStack.fetchLikedPosts()
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
}
