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
    
    let screenSize = UIScreen.main.bounds.size
    
    fileprivate var refreshControl = UIRefreshControl()
    fileprivate var viewModel = GalleryVCViewModel()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Gallery"
        
        self.collectionView.register(GalleryCell.self)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.collectionView.addSubview(self.refreshControl)
        
        self.setupReactive()
        
//        self.refreshControl.beginRefreshing()
        
        self.self.viewModel.reloadData()
    }
    
    // MARK: - Reactive
    
    fileprivate func setupReactive() {
        
//        self.refreshControl.reactive.controlEvents(.valueChanged).observeNext { [unowned self] (_) in
//            self.viewModel.reloadData()
//            }.dispose(in: self.bag)
        
        self.viewModel.endedUpdatingContentSignal.observeNext { [weak self] _ in
            guard let `self` = self else {
                return
            }
            
            self.updateContent()
            
            }.dispose(in: self.bag)
        
        self.viewModel.recieveErrorSignal.observeNext { [weak self] _ in
            guard let `self` = self else {
                return
            }
            self.showErrorAlert()
            self.updateContent()
            }.dispose(in: self.bag)
    }
    
    // MARK: - Private
    
    fileprivate func updateContent() {
//        self.refreshControl.endRefreshing()
//        self.refreshControl.isEnabled = true

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeue(GalleryCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GalleryCell {
            cell.setup(withViewModel: self.viewModel.cellViewModel(at: indexPath))
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.screenSize.width/2 - 5, height: self.screenSize.width/2 - 5)
    }
}
