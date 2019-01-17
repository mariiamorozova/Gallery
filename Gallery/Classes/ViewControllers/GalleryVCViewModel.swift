//
//  GalleryVCViewModel.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import Foundation
import ReactiveKit

class GalleryVCViewModel {
    let endedUpdatingContentSignal = SafePublishSubject<Error?>()
    let recieveErrorSignal = SafePublishSubject<Error?>()
    
    var numberOfRows: Int {
        return self.cellsData.count
    }
    
    var showInfScroll = false
    
    fileprivate var pagination: APIPagination = APIPagination()
    
    fileprivate var cellsData: [GalleryCellViewModel] = []
    
    // MARK: - Helpers
    
    func loadData() {
        self.performRequest()
    }
    
    func reloadData() {
        self.pagination.page = 1
        self.performRequest()
    }
    
    func cellViewModel(at indexPath: IndexPath) -> GalleryCellViewModel {
        return self.cellsData[indexPath.row]
    }
    
    // MARK: - Request
    
    fileprivate func performRequest() {
        APIProvider.getRecentPhotos(pagination: self.pagination, onCompletion: { (error: NSError?,
            flickrImages: [FlickrImage]?) -> Void in
            
            guard error == nil else {
                self.cellsData.removeAll()
                self.recieveErrorSignal.next(error)
                return
            }
        
            guard let photos = flickrImages else {
                self.recieveErrorSignal.next(error)
                return
            }
            
            if self.pagination.page == 1 {
                self.cellsData.removeAll()
            }
            
            self.checkHasMore(by: photos.count)
            self.pagination.next()
            
            for photo in photos {
                let cellViewModel = GalleryCellViewModel(withModel: photo.photoUrl)
                self.cellsData.append(cellViewModel)
            }
            
            self.endedUpdatingContentSignal.next(error)
            
        })
    }

    // MARK: - Private
    
    fileprivate func checkHasMore(by count: Int) {
        self.showInfScroll = count == self.pagination.per
    }
}
