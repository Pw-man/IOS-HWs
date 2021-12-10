//
//  VideoViewController.swift
//  Navigation
//
//  Created by Роман on 08.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: UIViewController {
        
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let videos: [Videofile] = [
        Videofile(url: URL(string: "https://www.youtube.com/embed/0AcvHuGeOZE?playsinline=1")!, image: UIImage(named: "render-audi-rs7")!, name: "Audi RS 7"),
        Videofile(url: URL(string: "https://www.youtube.com/embed/VOp9cpqE_EE?playsinline=1")!, image: UIImage(named: "maxresdefault")!, name: "Mercedes S Class L"),
        Videofile(url: URL(string: "https://www.youtube.com/embed/lVvK1OI3Cu4?playsinline=1")!, image: UIImage(named: "chiron")!, name: "BUGATTI Chiron Sport")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.dataSource = self
        tableView.delegate = self
        self.title = "Youtube videos"
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = .systemRed
    }
}

extension VideoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = VideoTableViewCell()
        cell.video = self.videos[indexPath.row]
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(200)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoPlayerVC = VideoPlayerViewController()
        videoPlayerVC.video = videos[indexPath.row]
        self.navigationController?.present(videoPlayerVC, animated: true, completion: nil)
    }
    
}
