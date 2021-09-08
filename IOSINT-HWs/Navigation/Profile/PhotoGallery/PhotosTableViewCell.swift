//
//  PhothosTableViewCell.swift
//  Navigation
//
//  Created by Роман on 16.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var titlePhotoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Photo gallery"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var firstImageView: UIImageView = {
        let fiv = UIImageView()
        fiv.image = #imageLiteral(resourceName: "pexels-dominika-roseclay-2023384")
        fiv.clipsToBounds = true
        fiv.contentMode = .scaleAspectFit
        fiv.roundCornersWithRadius(6, top: true, bottom: true, shadowEnabled: false)
        fiv.translatesAutoresizingMaskIntoConstraints = false
        return fiv
    }()
    
    var secondImageView: UIImageView = {
        let siv = UIImageView()
        siv.image = #imageLiteral(resourceName: "pexels-noelle-otto-906065")
        siv.clipsToBounds = true
        siv.contentMode = .scaleAspectFit
        siv.roundCornersWithRadius(6, top: true, bottom: true, shadowEnabled: false)
        siv.translatesAutoresizingMaskIntoConstraints = false
        return siv
    }()
    
    var thirdImageView: UIImageView = {
        let tiv = UIImageView()
        tiv.image = #imageLiteral(resourceName: "pexels-binyamin-mellish-169524")
        tiv.clipsToBounds = true
        tiv.contentMode = .scaleAspectFit
        tiv.roundCornersWithRadius(6, top: true, bottom: true, shadowEnabled: false)
        tiv.translatesAutoresizingMaskIntoConstraints = false
        return tiv
    }()
    
    var fourthImageView: UIImageView = {
        let fiv = UIImageView()
        fiv.image = #imageLiteral(resourceName: "pexels-rodnae-productions-7516789")
        fiv.clipsToBounds = true
        fiv.contentMode = .scaleAspectFit
        fiv.roundCornersWithRadius(6, top: true, bottom: true, shadowEnabled: false)
        fiv.translatesAutoresizingMaskIntoConstraints = false
        return fiv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = NSLayoutConstraint.Axis.horizontal
        sv.distribution = UIStackView.Distribution.equalSpacing
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    let arrowImageView: UIImageView = {
        let aiv = UIImageView()
        aiv.image = UIImage(systemName: "arrow.forward")
        aiv.tintColor = .black
        aiv.onAutoLayout()
        return aiv
    }()
    
    private let screenSize: CGRect = UIScreen.main.bounds
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        contentView.addSubview(titlePhotoLabel)
        contentView.addSubview(arrowImageView)
        
        stackView.addArrangedSubview(firstImageView)
        stackView.addArrangedSubview(secondImageView)
        stackView.addArrangedSubview(thirdImageView)
        stackView.addArrangedSubview(fourthImageView)
        
        NSLayoutConstraint.activate([
            titlePhotoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titlePhotoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titlePhotoLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12),
            
            arrowImageView.centerYAnchor.constraint(equalTo: titlePhotoLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            firstImageView.widthAnchor.constraint(equalToConstant: (screenSize.width - 48) / 4),
            firstImageView.heightAnchor.constraint(equalTo: firstImageView.widthAnchor),
            
            
            secondImageView.widthAnchor.constraint(equalToConstant: (screenSize.width - 48) / 4),
            secondImageView.heightAnchor.constraint(equalTo: firstImageView.widthAnchor),
            
            thirdImageView.widthAnchor.constraint(equalToConstant: (screenSize.width - 48) / 4),
            thirdImageView.heightAnchor.constraint(equalTo: firstImageView.widthAnchor),
            
            fourthImageView.widthAnchor.constraint(equalToConstant: (screenSize.width - 48) / 4),
            fourthImageView.heightAnchor.constraint(equalTo: firstImageView.widthAnchor),
            
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: titlePhotoLabel.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

extension UIView {
    
    /// Method adds shadow and corner radius for top of view by default.
    ///
    /// - Parameters:
    ///   - top: Top corners
    ///   - bottom: Bottom corners
    ///   - radius: Corner radius
    func roundCornersWithRadius(_ radius: CGFloat, top: Bool? = true, bottom: Bool? = true, shadowEnabled: Bool = true) {
        var maskedCorners = CACornerMask()
        
        if shadowEnabled {
            clipsToBounds = true
            layer.masksToBounds = false
            layer.shadowOpacity = 0.5
            layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).cgColor
            layer.shadowRadius = 4
            layer.shadowOffset = CGSize(width: 4, height: 4)
        }
        
        switch (top, bottom) {
        case (true, false):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case (false, true):
            maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case (true, true):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        default:
            break
        }
        
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
    
}
