//
//  ImageCollectionViewCell.swift
//  Ameenazon
//
//  Created by Ameen Mustafa on 9/14/21.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    static let identifier = "ImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with imageURL: URL) {
        productImageView.kf.setImage(with: imageURL)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }

}
