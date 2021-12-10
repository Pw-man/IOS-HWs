//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

class PostViewController: UIViewController {
    
    var post: Post?
    
    private lazy var toAudioVCButton = CustomButton(title: "Listen to music", font: .boldSystemFont(ofSize: 15), titleColor: .systemBlue) { [unowned self] in
        let audioVC = AudioViewController()
        self.navigationController?.pushViewController(audioVC, animated: true)
    }
    
    private lazy var toVideoVCButton = CustomButton(title: "Watch video", font: .boldSystemFont(ofSize: 15), titleColor: .systemBlue) { [unowned self] in
        let videoVC = VideoViewController()
        self.navigationController?.pushViewController(videoVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        view.backgroundColor = .white
        view.addSubview(toAudioVCButton)
        view.addSubview(toVideoVCButton)
        
        toAudioVCButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        toVideoVCButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentVC))
    }
    
    @objc private func presentVC() {
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: nil)
    }
}
