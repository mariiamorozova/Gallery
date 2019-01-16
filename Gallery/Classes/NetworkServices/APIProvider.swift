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
    
    class func getRecentPhotos(onCompletion: @escaping FlickrResponse) -> Void {
     
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(flickrKey)&format=json&nojsoncallback=1"
        let url: NSURL = NSURL(string: urlString)!
        let searchTask = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error -> Void in
            
            if let error = error {
                print("Error fetching photos: \(error)")
                onCompletion(error as NSError?, nil)
                return
            }
            
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results["code"] as? Int {
                    if statusCode == invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "com.flickr.api", code: statusCode, userInfo: nil)
                        onCompletion(invalidAccessError, nil)
                        return
                    }
                }
                
                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else { return }
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
                
                let flickrPhotos: [FlickrImage] = photosArray.map { photoDictionary in
                    
                    let photoId = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let title = photoDictionary["title"] as? String ?? ""
                    
                    let flickrPhoto = FlickrImage(photoId: photoId, farm: farm, secret: secret, server: server, title: title)
                    return flickrPhoto
                }
                
                onCompletion(nil, flickrPhotos)
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                onCompletion(error, nil)
                return
            }
            
        })
        searchTask.resume()
    }
    
}
