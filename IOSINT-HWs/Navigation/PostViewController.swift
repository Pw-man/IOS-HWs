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
    
    private var imageViewForTopPic: UIImageView = {
        let iv = UIImageView()
        iv.sizeToFit()
        return iv
    }()
    
    private var imageViewForBotPic: UIImageView = {
        let iv = UIImageView()
        iv.sizeToFit()
        return iv
    }()
    
    private var countdownLabel = UILabel()
    private var interval: Decimal = 2

    private lazy var startDownloadButton : CustomButton = .init(title: "Download", font: .boldSystemFont(ofSize: 15), titleColor: .black) { [weak self] in
        guard let self = self else { return }
        self.imageViewForTopPic.load(url: URL(string: "https://images.freeimages.com/images/large-previews/25d/eagle-1523807.jpg"
)!)
        self.imageViewForBotPic.load(url: URL(string: "https://images.freeimages.com/images/large-previews/afa/black-jaguar-1402097.jpg")!)
        
        let countdown = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.interval > 0 {
                self.interval -= 0.1
                self.countdownLabel.text = "\(self.interval)"
            } else {
                timer.invalidate()
                self.imageViewForTopPic.alpha = 1
                self.imageViewForBotPic.alpha = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.countdownLabel.text = "All data is uploaded!"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        view.addSubview(imageViewForTopPic)
        view.addSubview(startDownloadButton)
        view.addSubview(imageViewForBotPic)
        view.addSubview(countdownLabel)
        view.backgroundColor = .systemPink
        imageViewForTopPic.alpha = 0
        imageViewForBotPic.alpha = 0
        
        imageViewForTopPic.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.bottom.equalTo(startDownloadButton.snp.top).inset(-20)
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
        }
        
        imageViewForBotPic.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.top.equalTo(startDownloadButton.snp.bottom).inset(-20)
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
        }
        
        startDownloadButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(22)
        }
        startDownloadButton.backgroundColor = .systemBlue
        startDownloadButton.layer.cornerRadius = 5
        
        countdownLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(22)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentVC))
    }
    
    @objc private func presentVC() {
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: nil)
    }
}

//MARK: - UIImageView

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
