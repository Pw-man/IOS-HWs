//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: CustomButton = .init(title: "Show alert".localized(), font: .boldSystemFont(ofSize: 15), titleColor: .white) { [weak self] in
        guard let self = self else { return }
        let alertController = UIAlertController(title: "Delete post?".localized(), message: "Post couldn't be restored".localized(), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .default) { _ in
            print("Отмена".localized())
        }
        let deleteAction = UIAlertAction(title: "Delete".localized(), style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertButton)
        view.backgroundColor = .systemYellow
        
        alertButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
}
