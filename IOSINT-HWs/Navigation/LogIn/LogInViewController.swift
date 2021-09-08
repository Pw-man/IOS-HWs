//
//  LogInViewController.swift
//  Navigation
//
//  Created by Роман on 07.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private let VkLogoImage: UIImageView = {
      var vkLogo = UIImageView()
        vkLogo.image = #imageLiteral(resourceName: "logo")
        vkLogo.clipsToBounds = true
        return vkLogo
    }()
    
    private let logInView = LogInView()

    private(set) lazy var logInButton: UIButton = {
        var button = UIButton()
        return button
    }()
    
    private func UIElementsSettings() {
        logInView.backgroundColor = .systemGray6
        logInView.layer.borderColor = UIColor.lightGray.cgColor
        logInView.layer.borderWidth = 0.5
        logInView.layer.cornerRadius = 10
        
        logInButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        logInButton.setTitleColor(.white, for: [.disabled,.selected,.highlighted,.normal])
        logInButton.setTitle("Log In", for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
        logInButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        guard let pixelImage = UIImage(named: "blue_pixel") else { return }
        logInButton.setBackgroundImage(pixelImage.alpha(0.8), for: .selected)
        logInButton.setBackgroundImage(pixelImage.alpha(1), for: .normal)
        logInButton.setBackgroundImage(pixelImage.alpha(0.8), for: .disabled)
        logInButton.setBackgroundImage(pixelImage.alpha(0.8), for: .highlighted)

    }
   @objc private func buttonTapped() {
    let profileVC = storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileViewController
    navigationController?.pushViewController(profileVC, animated: true)
   
    }
    
    private func setupConstraints() {
        VkLogoImage.onAutoLayout()
        logInView.onAutoLayout()
        logInButton.onAutoLayout()
        scrollView.onAutoLayout()
        containerView.onAutoLayout()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            VkLogoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            VkLogoImage.widthAnchor.constraint(equalToConstant: 100),
            VkLogoImage.heightAnchor.constraint(equalToConstant: 100),
            VkLogoImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            logInView.topAnchor.constraint(equalTo: VkLogoImage.bottomAnchor, constant: 120),
            logInView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            logInView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            logInView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: logInView.bottomAnchor, constant: 16),
            logInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)

            
    ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIElementsSettings()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(logInView)
        containerView.addSubview(VkLogoImage)
        containerView.addSubview(logInButton)
        setupConstraints()
        self.logInView.nameTextField.delegate = self
        self.logInView.passwordTextField.delegate = self
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
        
}

extension UIView {
    func onAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
}
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension LogInViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        logInView.passwordTextField.resignFirstResponder()
        logInView.nameTextField.resignFirstResponder()
        return true
    }
}
