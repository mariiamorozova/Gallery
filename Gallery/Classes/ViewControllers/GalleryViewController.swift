//
//  GalleryViewController.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(GalleryCell.self)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 //for test
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeue(GalleryCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GalleryCell {
            cell.setup(withViewModel: GalleryCellViewModel(withModel: "test"))
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 176, height: 230)
    }
}
