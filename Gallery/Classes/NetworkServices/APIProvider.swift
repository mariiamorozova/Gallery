//
//  APIProvider.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import Foundation

class APIProvider {
    
    typealias FlickrResponse = (NSError?, [FlickrImage]?) -> Void
    static let flickrKey = "1ac7298cb4f67bbdb085d6e8ab7f6303"
    static let invalidAccessErrorCode = 100
    
    class func getRecentPhotos(pagination: APIPagination? = nil, onCompletion: @escaping FlickrResponse) -> Void {
     
        var urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(flickrKey)&format=json&nojsoncallback=1"
        
        if let pagination = pagination {
            urlString += "&per_page=\(pagination.per)&page=\(pagination.page)"
        }
        
        let url: NSURL = NSURL(string: urlString)!
        let searchTask = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error -> Void in
            
            if let error = error {
                print("Error fetching images: \(error)")
                onCompletion(error as NSError?, nil)
                return
            }
            
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results["code"] as? Int {
                    if statusCode == invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "flickr.api", code: statusCode, userInfo: nil)
                        onCompletion(invalidAccessError, nil)
                        return
                    }
                }
                
                guard let imagesContainer = resultsDictionary!["photos"] as? NSDictionary else {
                    return
                }
                guard let imagesArray = imagesContainer["photo"] as? [NSDictionary] else {
                    return
                }
                
                let flickrImages: [FlickrImage] = imagesArray.map { photoDictionary in
                    let imageId = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let title = photoDictionary["title"] as? String ?? ""
                    
                    let flickrPhoto = FlickrImage(photoId: imageId, farm: farm, secret: secret, server: server, title: title)
                    return flickrPhoto
                }
                
                onCompletion(nil, flickrImages)
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                onCompletion(error, nil)
                return
            }
        })
        searchTask.resume()
    }
    
}
