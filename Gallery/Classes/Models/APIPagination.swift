//
//  APIPagination.swift
//  Gallery
//
//  Created by Mariia Morozova on 17/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import Foundation

struct APIPagination {
    var page: Int
    let per: Int
    
    var params: [String: Any] {
        return ["page": self.page,
                "per_page": self.per]
    }
    
    init(page: Int = 1, per: Int = 15) {
        self.page = page
        self.per = per
    }
    
    mutating func next() {
        self.page += 1
    }
}
