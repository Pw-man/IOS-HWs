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
    private var isInitiallyLoaded = false
    private var isPostsSorted = false
    
    private lazy var fetchResultController: NSFetchedResultsController<LikedPost> = {
        let request: NSFetchRequest<LikedPost> = LikedPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataStack.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show all posts", style: .plain, target: self, action: #selector(undoSortingLikedPosts))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort by author", style: .plain, target: self, action: #selector(sortLikedPost))
    }
    
    private func startFetchResultController() {
        coreDataStack.viewContext.perform {
            do {
                try self.fetchResultController.performFetch()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func startFetchResultControllerSync(_ controller: NSFetchedResultsController<LikedPost>) {
        coreDataStack.viewContext.performAndWait {
            do {
                try controller.performFetch()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func presentAlertVC(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let userTapToContinue = UIAlertAction(title: actionTitle, style: .default)
        alertController.addAction(userTapToContinue)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func sortLikedPost() {
        let alertController = UIAlertController(title: "Preferred author", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter author's name"
        }
        let sortAction = UIAlertAction(title: "Sort posts", style: .default) { [weak self] _ in
            let textField = alertController.textFields![0]
            guard let self = self, let enteredText = textField.text else { return }
            guard !enteredText.isEmpty else {
                self.presentAlertVC(title: "Input field is empty!",
                                    message: "Enter some text, please",
                                    actionTitle: "Ok")
                return
            }
            let predicate = NSPredicate(format: "%K == %@", #keyPath(LikedPost.author), enteredText)
            self.fetchResultController.fetchRequest.predicate = predicate
            self.startFetchResultControllerSync(self.fetchResultController)
            guard let bufferArray = self.fetchResultController.fetchedObjects else {
                print("problem with fetching")
                return
            }
            guard !bufferArray.isEmpty else {
                self.presentAlertVC(title: "No such authors",
                                    message: "Correct request, please",
                                    actionTitle: "Ok")
                self.fetchResultController.fetchRequest.predicate = nil
                self.startFetchResultController()
                return
            }
            self.isPostsSorted = true
            self.startFetchResultController()
        }
        alertController.addAction(sortAction)
        self.present(alertController, animated: true)
    }
    
    @objc func undoSortingLikedPosts() {
        if isPostsSorted {
            fetchResultController.fetchRequest.predicate = nil
            isPostsSorted = false
            startFetchResultController()
        }
    }
    
    init(viewModel: LikedPostsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isInitiallyLoaded {
            isInitiallyLoaded.toggle()
            startFetchResultController()
        }
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
    }
}

extension LikedPostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchResultController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LikedPostTableViewCell
        cell.likedPost = fetchResultController.object(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete post") { [weak self] action, view, completionHandler in
            guard let self = self else { return }
            let likedPost = self.fetchResultController.object(at: indexPath)
            coreDataStack.remove(likedPost: likedPost)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "minus.circle.fill")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension LikedPostsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

//MARK: - Old func sortLikedPosts() logic, to save screen condition

//    @objc func sortLikedPost() {
//        let alertController = UIAlertController(title: "Preferred author", message: "", preferredStyle: .alert)
//        alertController.addTextField { textField in
//            textField.placeholder = "Enter author's name"
//        }
//        let sortAction = UIAlertAction(title: "Sort posts", style: .default) { [weak self] _ in
//            let textField = alertController.textFields![0]
//            guard let self = self, let enteredText = textField.text else { return }
//
//            guard !enteredText.isEmpty else {
//                self.presentAlertVC(title: "Input field is empty!",
//                                    message: "Enter some text, please",
//                                    actionTitle: "Ok")
//                return
//            }
//            let fetchResultControllerForSorted: NSFetchedResultsController<LikedPost> = {
//                let request: NSFetchRequest<LikedPost> = LikedPost.fetchRequest()
//                request.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: false)]
//                let predicate = NSPredicate(format: "%K == %@", #keyPath(LikedPost.author), enteredText)
//                request.predicate = predicate
//                let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataStack.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//                controller.delegate = self
//                return controller
//            }()
//            self.startFetchResultControllerSync(fetchResultControllerForSorted)
//            guard let bufferArray = fetchResultControllerForSorted.fetchedObjects else {
//                print("problem with fetching")
//                return
//            }
//            guard !bufferArray.isEmpty else {
//                self.presentAlertVC(title: "No such authors",
//                                    message: "Correct request, please",
//                                    actionTitle: "Ok")
//                return
//            }
//            self.fetchResultController = fetchResultControllerForSorted
//            self.isPostsSorted = true
//            self.startFetchResultController()
//        }
//        alertController.addAction(sortAction)
//        self.present(alertController, animated: true)
//    }

