//
//  FlickrImage.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import Foundation
import UIKit

struct FlickrImage {
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_m.jpg"
    }
}
