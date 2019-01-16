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
    
    fileprivate var cellsData: [GalleryCellViewModel] = []
    
    // MARK: - Helpers
    
    func reloadData() {
        self.performRequest()
    }
    
    func cellViewModel(at indexPath: IndexPath) -> GalleryCellViewModel {
        return self.cellsData[indexPath.row]
    }
    
    // MARK: - Request
    
    private func performRequest() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        APIProvider.getRecentPhotos(onCompletion: { (error: NSError?, flickrPhotos: [FlickrImage]?) -> Void in
            if error == nil {

                guard let photos = flickrPhotos else {
                    self.recieveErrorSignal.next(error)
                    return
                }
        
                self.cellsData.removeAll()
                
                for photo in photos {
                    let cellViewModel = GalleryCellViewModel(withModel: photo.photoUrl)
                    self.cellsData.append(cellViewModel)
                }
                self.endedUpdatingContentSignal.next(error)
            } else {
                self.cellsData.removeAll()
                self.recieveErrorSignal.next(error)
            }
        })
    }
}
