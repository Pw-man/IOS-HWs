//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Роман on 08.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import AVKit

class VideoTableViewCell: UITableViewCell {
    
    var video: Videofile? {
        didSet {
            guard let video = video else { return }
            self.videoPreviewImage.image = video.image
            self.nameLabel.text = video.name
        }
    }
    private let playerVideoController = AVPlayerViewController()
    private var player = AVPlayer()

    private let videoPreviewImage: UIImageView = {
       let iv = UIImageView()
       return iv
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(videoPreviewImage)
        contentView.addSubview(nameLabel)
        
        videoPreviewImage.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.leading.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(videoPreviewImage.snp.trailing).offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
