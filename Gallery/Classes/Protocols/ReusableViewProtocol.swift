//
//  ReusableViewProtocol.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import UIKit

protocol ReusableViewProtocol: class {}

extension ReusableViewProtocol where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableViewProtocol { }
