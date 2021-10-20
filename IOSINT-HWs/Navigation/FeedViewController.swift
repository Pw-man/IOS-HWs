//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

final class FeedViewController: UIViewController {
    
    private let notificationCenter = NotificationCenter.default
    private let model: FeedViewControllerModel
    
    init(model: FeedViewControllerModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let passTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insert password"
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    private let coloredLabel : UILabel = {
        let label = UILabel()
        label.text = "It's test text"
        return label
    }()
    
    private lazy var checkPassButton: CustomButton = .init(title: "Verify password", font: .boldSystemFont(ofSize: 15), titleColor: .white) { [weak self] in
        guard let self = self else { return }
        self.notificationCenter.post(name: .boolChanged, object: nil)
//        if self.model.check(word: self.passTextField.text!) {
//            self.coloredLabel.textColor = .green
//        } else {
//            self.coloredLabel.textColor = .systemRed
//        }
    }
    
    private lazy var pushPostVCButton: CustomButton = .init(title: "Click me", font: .boldSystemFont(ofSize: 15), titleColor: .systemBlue) { [weak self] in
        guard let self = self else { return }
        let postVC = PostViewController()
        postVC.post = self.post
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    let post: Post = Post(title: "Post")
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        view.backgroundColor = .systemGreen
        view.addSubview(pushPostVCButton)
        view.addSubview(checkPassButton)
        view.addSubview(passTextField)
        view.addSubview(coloredLabel)
        
        pushPostVCButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    
        checkPassButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pushPostVCButton.snp.top).inset(-100)
        }
        
        passTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(checkPassButton.snp.top).inset(-100)
        }
        
        coloredLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pushPostVCButton.snp.top).inset(100)
        }
    }
    
    @objc func pickLabelColor(_ notification: Notification) {
        if model.check(word: passTextField.text!) {
            self.coloredLabel.textColor = .green
        } else {
            self.coloredLabel.textColor = .systemRed
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        
       notificationCenter.addObserver(self, selector: #selector(pickLabelColor), name: .boolChanged, object: nil)
        
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
}

extension Notification.Name {
    static let boolChanged = Notification.Name("boolChanged")
}

