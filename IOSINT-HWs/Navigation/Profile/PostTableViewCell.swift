//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Роман on 10.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var profilePost: ProfilePost? {
        didSet {
            guard let profilePost = profilePost else { return }
            postAuthorLabel.text = profilePost.author
            postTextLabel.text = profilePost.description
            postLikesLabel.text = "Likes: \(profilePost.likes)"
            postViewsLabel.text = "Views: \(profilePost.views)"
            postImageView.image = UIImage(named: "\(profilePost.image)")
        } 
    }
    
    private var postImageView: UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .black
        iv.onAutoLayout()
        return iv
    }()
    
    private var postAuthorLabel: UILabel = {
        var pal = UILabel()
        pal.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        pal.textColor = .black
        pal.numberOfLines = 2
        pal.onAutoLayout()
        return pal
    }()
    
    private var postTextLabel: UILabel = {
        var ptl = UILabel()
        ptl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        ptl.textColor = .systemGray
        ptl.numberOfLines = 0
        ptl.onAutoLayout()
        return ptl
    }()
    
    private var postLikesLabel: UILabel = {
        var pll = UILabel()
        pll.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        pll.textColor = .black
        pll.onAutoLayout()
        pll.sizeToFit()
        return pll
    }()
    
    private var postViewsLabel: UILabel = {
        var pvl = UILabel()
        pvl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        pvl.textColor = .black
        pvl.onAutoLayout()
        pvl.sizeToFit()
        return pvl
    }()
    
    private func setupViews() {
        contentView.addSubview(postViewsLabel)
        contentView.addSubview(postLikesLabel)
        contentView.addSubview(postTextLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(postAuthorLabel)
        
        let constraints = [
            postAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postAuthorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postAuthorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            postImageView.topAnchor.constraint(equalTo: postAuthorLabel.bottomAnchor),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            postTextLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            postTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postLikesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikesLabel.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 16),
            postLikesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            postViewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postViewsLabel.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 16),
            postViewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
