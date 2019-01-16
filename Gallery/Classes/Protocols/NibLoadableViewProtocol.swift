//
//  NibLoadableViewProtocol.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import UIKit

protocol NibLoadableViewProtocol: class {}

extension NibLoadableViewProtocol where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
}

extension UICollectionReusableView: NibLoadableViewProtocol { }
