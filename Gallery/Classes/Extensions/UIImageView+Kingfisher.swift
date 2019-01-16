//
//  UIImageView+Kingfisher.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlStr: String?, placeholder placeholderName: String? = nil, asTemplate template: Bool = false) {
        let placeholderImage: UIImage?
        
        if let imgName = placeholderName {
            placeholderImage = UIImage(named: imgName)
        } else {
            placeholderImage = UIImage(named: "placeholderDefault")
        }
        
        if let urlString = urlStr, let url = URL(string: urlString) {
            self.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.2))],
                             completionHandler: { [weak self] (image, _, _, _) in
                                if template {
                                    self?.image = image?.withRenderingMode(.alwaysTemplate)
                                }
            })
        } else {
            self.image = placeholderImage
        }
    }
}
