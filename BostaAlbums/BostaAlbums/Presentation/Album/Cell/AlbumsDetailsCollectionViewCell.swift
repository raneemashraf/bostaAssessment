//
//  AlbumsDetailsCollectionViewCell.swift
//  BostaAlbums
//
//  Created by raneem on 01/03/2025.
//

import UIKit

class AlbumsDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with photo: Photo) {
        if let url = URL(string: photo.url) {
            photoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "red"))
        }
    }
    
}
