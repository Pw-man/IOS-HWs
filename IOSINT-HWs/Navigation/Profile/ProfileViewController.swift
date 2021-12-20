//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Роман on 05.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController: UIViewController {
    
    private let imageProcessor = ImageProcessor()
    private var user : UserService
    private var nameOfUser: String
    
    init(user : UserService, name: String) {
        self.user = user
        self.nameOfUser = name
        super.init(nibName: nil, bundle: nil)
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    
    private var transparentUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.onAutoLayout()
        return view
    }()
        
    private var animatedProfileHeaderView: ProfileHeaderView = {
        let phv = ProfileHeaderView()
        phv.onAutoLayout()
        return phv
    }()
    
    private lazy var closeButton: CustomButton = .init(title: "", font: .systemFont(ofSize: 15), titleColor: .systemRed) { [weak self] in
        guard let self = self else { return }
        func deAnimate() {
            UIView.animate(withDuration: 0.5, animations: {
                self.animatedProfileHeaderView.avatarImageView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.animatedProfileHeaderView.avatarImageView.frame = .init(x: 16, y: 63, width: 120, height: 120)
                self.animatedProfileHeaderView.avatarImageView.layer.cornerRadius = 60
                self.transparentUIView.alpha = 0
                self.animatedProfileHeaderView.avatarImageView.alpha = 0

            }, completion: {_ in
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.closeButton.alpha = 0
                })
            })
        }
        deAnimate()
    }

    func schemeActivator() {
        if SchemeCheck.isInDebugMode {
            tableView.backgroundColor = .systemYellow
            user = TestUserService()
        } else {
            tableView.backgroundColor = .green
    }
}
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        guard let crossImg = UIImage(systemName: "xmark.square.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle)) else { return }
        let redCross = crossImg.withTintColor(.systemRed)
        closeButton.setBackgroundImage(redCross.alpha(1), for: .normal)
        closeButton.setBackgroundImage(redCross.alpha(0.6), for: .highlighted)
        closeButton.alpha = 0
        closeButton.onAutoLayout()
        
        view.addSubview(transparentUIView)
        view.addSubview(animatedProfileHeaderView.avatarImageView)
        view.addSubview(closeButton)
        
        animatedProfileHeaderView.avatarImageView.alpha = 0

        let constraints = [
            transparentUIView.topAnchor.constraint(equalTo: view.topAnchor),
            transparentUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            transparentUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transparentUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tapOnProfilePhoto() {
        func animate() {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.animatedProfileHeaderView.avatarImageView.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
                self.animatedProfileHeaderView.avatarImageView.center = self.transparentUIView.center
                self.animatedProfileHeaderView.avatarImageView.frame = .init(x: 0, y: ((screenSize.height - screenSize.width) / 2) , width: screenSize.width, height: screenSize.width)
                self.animatedProfileHeaderView.avatarImageView.layer.cornerRadius = 0
                self.transparentUIView.alpha = 0.75
                self.animatedProfileHeaderView.avatarImageView.alpha = 1
                
            }, completion: {_ in
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.closeButton.alpha = 1
                })
            })
        }
        animate()
    }
        
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.onAutoLayout()
        schemeActivator()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: reuseID)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.postsArray.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pvc = PhotosViewController()
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(pvc, animated: true)
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = PhotosTableViewCell()
            return cell
        case 1:
            let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostTableViewCell
            cell.profilePost = Posts.postsArray[indexPath.row]
            imageProcessor.processImage(sourceImage: Posts.postsArray[1].image, filter: .crystallize(radius: 12)) { filterImg in
                cell.profilePost?.image = filterImg!
            }
                return cell
        case 2:
              let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostTableViewCell
            cell.profilePost = Posts.postsArray[indexPath.row]
            imageProcessor.processImage(sourceImage: Posts.postsArray[2].image, filter: .bloom(intensity: 0.5)) { filterImg in
                cell.profilePost?.image = filterImg!
            }
                return cell
        case 3:
            let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostTableViewCell
            cell.profilePost = Posts.postsArray[indexPath.row]
            imageProcessor.processImage(sourceImage: Posts.postsArray[3].image, filter: .monochrome(color: .blue, intensity: 0.9)) { filterImg in
                cell.profilePost?.image = filterImg!
            }
                return cell
        case 4:
            let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostTableViewCell
            cell.profilePost = Posts.postsArray[indexPath.row]
            imageProcessor.processImage(sourceImage: Posts.postsArray[4].image, filter: .sepia(intensity: 0.7)) { filterImg in
                cell.profilePost?.image = filterImg!
            }
                return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
}

    func configureHeaderView() -> ProfileHeaderView {
        let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseID) as! ProfileHeaderView
        do {
            let theUser = try user.returnUser(name: nameOfUser)
            profileHeaderView.fullNameLabel.text = theUser.fullName
            profileHeaderView.avatarImageView.image = theUser.avatar
            profileHeaderView.statusLabel.text = theUser.status
            
        } catch UserServiceError.unnownUser(let wrongUser) {
            profileHeaderView.fullNameLabel.text = wrongUser.fullName
            profileHeaderView.avatarImageView.image = wrongUser.avatar
            profileHeaderView.statusLabel.text = wrongUser.status
        } catch {
            print("\(error)")
        }
        return profileHeaderView
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = configureHeaderView()
        let tapOnPhoto = UITapGestureRecognizer(target: self, action: #selector(tapOnProfilePhoto))
        profileHeaderView.avatarImageView.addGestureRecognizer(tapOnPhoto)
        profileHeaderView.avatarImageView.isUserInteractionEnabled = true
        
        return profileHeaderView
    }
}
    
