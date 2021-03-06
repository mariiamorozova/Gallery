//
//  GalleryCellViewModel.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import Foundation

final class GalleryCellViewModel {
    
    var imageUrl: String
    
    init(withModel imageUrl: String) {
        self.imageUrl = imageUrl
    }
}
