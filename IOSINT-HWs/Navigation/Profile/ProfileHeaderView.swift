//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Роман on 05.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

let reuseID = String(describing: ProfileHeaderView.self)

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var avatarImageView = UIImageView()
    var fullNameLabel = UILabel()
    var statusLabel = UILabel()
    var setStatusButton = UIButton()
    var statusTextField = UITextField()
    
    
    func subViewsSettings(){
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.cornerRadius = 60
        avatarImageView.clipsToBounds = true
        avatarImageView.image = #imageLiteral(resourceName: "dachshundPhoto")
        avatarImageView.onAutoLayout()
        
        fullNameLabel.text = "Coolest Dog Ever"
        fullNameLabel.textColor = .black
        fullNameLabel.numberOfLines = 0
        fullNameLabel.onAutoLayout()
        
        statusLabel.textColor = .gray
        statusLabel.text = "Waiting for something..."
        statusLabel.onAutoLayout()
        
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.setTitle("Show Status", for: .normal)
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        setStatusButton.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        setStatusButton.onAutoLayout()
        
        statusTextField.textColor = .black
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.onAutoLayout()
        statusTextField.placeholder = "Set your status"
    }
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(setStatusButton)
        contentView.addSubview(fullNameLabel)
        
        subViewsSettings()
        
        let constraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            
            
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 40),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 152),
            statusTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var statusText: String = " "
    
    @objc private func statusButtonPressed() {
        
        statusTextChanged(statusTextField)
        statusLabel.text = statusText
        
        guard let text = statusLabel.text else {
            return
            
        }
        print("\(text)")
    }
    
    @objc private func statusTextChanged(_ textFieldInternal: UITextField) {
        statusText = textFieldInternal.text!
    }
    
}
