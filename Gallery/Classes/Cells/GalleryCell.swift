//
//  GalleryCell.swift
//  Gallery
//
//  Created by Mariia Morozova on 16/01/2019.
//  Copyright © 2019 Mariia Morozova. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: GalleryCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(withViewModel viewModel: GalleryCellViewModel) {
        self.viewModel = viewModel
        self.imageView.setImage(with: viewModel.imageUrl)
    }
}
