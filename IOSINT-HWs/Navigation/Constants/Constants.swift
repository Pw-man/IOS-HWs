//
//  Constants.swift
//  Navigation
//
//  Created by Роман on 05.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

let screnSize = UIScreen.main.bounds

struct SchemeCheck {
    static var isInDebugMode: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}

final class CustomButton: UIButton {
    private var buttonExecution: () -> Void
    
    init(title: String, font: UIFont, titleColor: UIColor, buttonExecution: @escaping () -> Void) {
        self.buttonExecution = buttonExecution
        
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    @objc func buttonTap() {
        buttonExecution()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


