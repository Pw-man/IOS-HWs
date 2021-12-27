//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

final class FeedViewController: MVVMController {
    
//    private let notificationCenter = NotificationCenter.default
    private var hackedPass = ""
    private let spinner = UIActivityIndicatorView()

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
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let coloredLabel : UILabel = {
        let label = UILabel()
        label.text = "It's test text"
        label.textColor = .systemGray
        return label
    }()
    
    /// Observing property
    //    private var password = "" {
    //        didSet {
    //            if self.model.check(word: password) {
    //                self.coloredLabel.textColor = .green
    //            } else {
    //                self.coloredLabel.textColor = .systemRed
    //            }
    //        }
    //    }
    
    private lazy var checkPassButton: CustomButton = .init(title: "Verify password", font: .boldSystemFont(ofSize: 15), titleColor: .white) { [weak self] in
        guard let self = self else { return }
        
        ///  Through Notification Center
        //        self.notificationCenter.post(name: .boolChanged, object: nil)
        
        /// Through closures
//        if self.viewModel.check(word: self.passTextField.text!) {
//            self.coloredLabel.textColor = .green
//        } else {
//            self.coloredLabel.textColor = .systemRed
//        }
        
        /// Through property observer  (DidSet)
        //        self.password = self.passTextField.text!
    }
    
    
    @objc func checkPass() {
        guard let enteredText = passTextField.text else { return }
        viewModel.onDataChanged?("\(enteredText)")
        
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
    
    private lazy var generatePassButton: CustomButton = .init(title: "Подобрать пароль", font: .boldSystemFont(ofSize: 15), titleColor: .black) { [weak self] in
        guard let self = self else { return }
        let randomStr = self.randomString(length: 3)
        self.spinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.bruteForce(passwordToUnlock: randomStr)
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.passTextField.isSecureTextEntry = false
                self.passTextField.text = self.hackedPass
            }
        }
    }
    
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }
        
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }
        hackedPass = password
    }
    
    func randomString(length: Int) -> String {
        let letters = String().printable
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    let post: Post = Post(title: "Post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        checkPassButton.addTarget(self, action: #selector(checkPass), for: .touchUpInside)
        
        view.backgroundColor = .systemGreen
        view.addSubview(pushPostVCButton)
        view.addSubview(checkPassButton)
        view.addSubview(passTextField)
        view.addSubview(coloredLabel)
        view.addSubview(spinner)
        view.addSubview(generatePassButton)
        spinner.style = .large
        
        pushPostVCButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        checkPassButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pushPostVCButton.snp.top).inset(-90)
        }
        
        passTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(checkPassButton.snp.top).inset(-100)
        }
        
        coloredLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pushPostVCButton.snp.top).inset(90)
        }
        
        generatePassButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passTextField.snp.bottom).inset(-30)
        }
        
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passTextField.snp.top).inset(-30)
        }
    }
    
    /// Notification Center  method
    //    @objc func pickLabelColor(_ notification: Notification) {
    //        if model.check(word: passTextField.text!) {
    //            self.coloredLabel.textColor = .green
    //        } else {
    //            self.coloredLabel.textColor = .systemRed
    //        }
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //       notificationCenter.addObserver(self, selector: #selector(pickLabelColor), name: .boolChanged, object: nil)
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
        viewModel.onDidDissapear?()
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

//extension Notification.Name {
//    static let boolChanged = Notification.Name("boolChanged")
//}

//MARK: - Bruteforce settings

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
    : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string
    
    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
        
        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }
    return str
}
