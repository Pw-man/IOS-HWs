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
                                             )!) { result in
            switch result {
            case .success(let successString):
                print(successString)
            case .failure(let error):
                print("\(error)")
            }
        }
        
        self.imageViewForBotPic.load(url: URL(string: "https://images.freeimages.com/images/large-previews/afa/black-jaguar-1402097.jpg")!) { result in
            switch result {
            case .success(let successString):
                print(successString)
            case .failure(let error):
                print("\(error)")
            }
        }
        
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
        
    private lazy var toAudioVCButton = CustomButton(title: "Listen to music", font: .boldSystemFont(ofSize: 15), titleColor: .systemBlue) { [unowned self] in
        let audioVC = AudioViewController()
        self.navigationController?.pushViewController(audioVC, animated: true)
    }
    
    private lazy var toVideoVCButton = CustomButton(title: "Watch video", font: .boldSystemFont(ofSize: 15), titleColor: .systemBlue) { [unowned self] in
        let videoVC = VideoViewController()
        self.navigationController?.pushViewController(videoVC, animated: true)
    }
    
    var postVCCompletion: (() -> Void)?
    
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
        view.backgroundColor = .white
        view.addSubview(toAudioVCButton)
        view.addSubview(toVideoVCButton)
        
        toAudioVCButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        toVideoVCButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().inset(16)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentVC))
    }
    
    @objc private func presentVC() {
        postVCCompletion?()
    }
}

//MARK: - UIImageView

extension UIImageView {
    func load(url: URL, completionHandler: @escaping (Result<String,NetworkError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            guard let data = try? Data(contentsOf: url) else { completionHandler(.failure(.badURL))
                return
            }
            guard let image = UIImage(data: data) else { completionHandler(.failure(.badData))
                return
            }
            DispatchQueue.main.async {
                self.image = image
                completionHandler(.success("All data is downloaded succesfully"))
            }
        }
    }
}


