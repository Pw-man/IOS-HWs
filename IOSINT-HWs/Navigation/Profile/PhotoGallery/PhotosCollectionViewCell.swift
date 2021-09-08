//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Роман on 17.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var peselPhoto: PeselPhoto? {
        didSet {
            guard let peselPhoto = peselPhoto else { return }
            photoImageView.image = UIImage(named: "\(peselPhoto.photo)")
            
        }
    }
    
    private let photoImageView: UIImageView = {
        let piv = UIImageView()
        piv.onAutoLayout()
        return piv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: (screenSize.width - 8 * 4) / 3),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
