//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

final class FeedViewController: UIViewController & CustomViewController {
    
    var viewModel: ViewInput & ViewOutput
    
    init(viewModel: ViewInput & ViewOutput) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pushNextVC: (() -> Void)?
    
    private let passTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insert password"
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    private let coloredLabel : UILabel = {
        let label = UILabel()
        label.text = "It's test text"
        label.textColor = .white
        return label
    }()
    
    private lazy var checkPassButton: UIButton = {
        let button = UIButton()
        button.setTitle("Verify password", for: .normal)
        return button
    }()
    
    @objc func checkPass() {
        viewModel.onDataChanged!("\(passTextField.text!)")
        
        switch viewModel.configuration {
        case .first:
            coloredLabel.textColor = .green
        case .second:
            coloredLabel.textColor = .systemRed
        case .none:
            break
        }
        
        print(type(of: self), #function)
    }
    
    private lazy var pushPostVCButton: CustomButton = .init(title: "Click me", font: .boldSystemFont(ofSize: 15), titleColor: .systemBlue) { [weak self] in
        guard let self = self else { return }
        self.pushNextVC?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        checkPassButton.addTarget(self, action: #selector(checkPass), for: .touchUpInside)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        let feedCoord = viewModel.coordinator as! FeedCoordinator
        feedCoord.VCDidDissapear()
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
