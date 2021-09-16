////
////  imageCarouselCollectionCell.swift
////  Ameenazon
////
////  Created by Ameen Mustafa on 8/28/21.
////
//
//import UIKit
//import Kingfisher
//
//class ImagesCarouselCollectionCell: UICollectionViewCell {
//    static let identifier = "ImageCarouselCell"
//    @IBOutlet weak var imageView: UIImageView!
//    
//    var imageURL: String! {
//        didSet {
//            print("whoore")
//            self.updateUI()
//        }
//    }
//    
//    func updateUI(){
//        if let image = imageURL {
//            let url = URL(string: image)
//            print(url)
//            imageView.kf.setImage(with: url)
//        }
//    }
//}
