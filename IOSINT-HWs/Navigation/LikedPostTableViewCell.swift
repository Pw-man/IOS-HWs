//
//  LikedPostTableViewCell.swift
//  Navigation
//
//  Created by Роман on 05.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

class LikedPostTableViewCell: PostTableViewCell {

    var likedPost: LikedPost? {
        didSet {
            guard let likedPost = likedPost else { return }
//            let stringTransformerToLower = StringTransform("Cyrillic")
            postAuthorLabel.text = likedPost.author
            postTextLabel.text = likedPost.postDescription
            postLikesLabel.text = "Likes: ".localized() + "\(likedPost.likes)"
            postViewsLabel.text = "Views: ".localized() + "\(likedPost.views)"
            postImageView.image = UIImage(named: likedPost.image ?? "questionmark.circle")
        }
    }
    
    @objc override func doubleTapAction() {
        // nothing happens now
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    

    
}
