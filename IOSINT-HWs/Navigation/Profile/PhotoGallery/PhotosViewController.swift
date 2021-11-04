//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Роман on 17.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    private var eraseTimer = Timer()
    private var imagesFromTimer = [UIImage]()
    private let layoutForPhotosVC = UICollectionViewFlowLayout()
    private let imagePublisherFacade = ImagePublisherFacade()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutForPhotosVC)
    
    private func collectionViewFillingLogic(repeatCount: Int, time: TimeInterval) {
        imagePublisherFacade.addImagesWithTimer(time: time, repeat: repeatCount, userImages: PeseliPhotos.photosArray)
        func createTimer() {
            eraseTimer = Timer.scheduledTimer(withTimeInterval: Double(repeatCount) * time + 2.0, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.imagePublisherFacade.rechargeImageLibrary()
            self.imagePublisherFacade.removeSubscription(for: self)
        }
        }
        createTimer()
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imagePublisherFacade.subscribe(self)
        setupCollectionView()
        collectionViewFillingLogic(repeatCount: 21, time: 0.2)

        self.navigationItem.title = "Photo Gallery"
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

private extension PhotosViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.onAutoLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        collectionView.backgroundColor = .white
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesFromTimer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.peselPhoto = imagesFromTimer[indexPath.item]
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (screenSize.width - 8 * 4) / 3, height: (screenSize.width - 8 * 4) / 3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        imagesFromTimer = images
        self.collectionView.reloadData()
    }
}
