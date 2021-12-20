//
//  VideoPlayerViewController.swift
//  Navigation
//
//  Created by Роман on 08.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import WebKit

class VideoPlayerViewController: UIViewController {
    
    var video: Videofile?

    let webPlayerView = UIView()
    private let playerVideoController = AVPlayerViewController()
    var webPlayer : WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webPlayerView)

        webPlayerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }

        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true

        DispatchQueue.main.async {
            self.webPlayer = WKWebView(frame: self.webPlayerView.bounds, configuration: webConfiguration)
            self.webPlayerView.addSubview(self.webPlayer)

            guard let videoUrl = self.video?.url else {
                print("Url is not valid")
                return
            }
            let request = URLRequest(url: videoUrl)
            self.webPlayer.load(request)
    }
}
}

