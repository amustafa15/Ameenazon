//
//  ImageCarouselCell.swift
//  Ameenazon
//
//  Created by Ameen Mustafa on 9/8/21.
//

import UIKit
import Kingfisher

class ImageCarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    var imageURL: String! {
        didSet {
//            self.productImageView.backgroundColor = .systemGreen
//            self.productImageView.kf.setImage(with: imageURL)
//            print(self.productImageView.bounds.size.width)
//            print(self.productImageView.bounds.size.height)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
