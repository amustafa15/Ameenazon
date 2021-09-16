//
//  ProductViewController.swift
//  Ameenazon
//
//  Created by Ameen Mustafa on 8/24/21.
//

import UIKit
import Kingfisher

class ProductViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var stackedView: UIStackView!
    @IBOutlet weak var detailedView: UIView!
    @IBOutlet var detailPageView: UIScrollView!
    @IBOutlet var imagesCarouselCollection: UICollectionView!
    @IBOutlet weak var imagesCarouselCollectionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var features: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var noOfReviews: UILabel!
//    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var buyNowBtn: UIButton!

    var searchedText: String = ""
    var asinForSearch: String = ""
    var resultsManager = ResultsManager()
    var productDeets: Products?
    var imagesArray = Array<String>()
    let customAlert = MyAlert()

    override func viewDidLoad() {
        super.viewDidLoad()

        resultsManager.detailsDelegate = self
        search()
        self.setupUI()
        loadingIndicator.isAnimating = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 349, height: 410)
        imagesCarouselCollection.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        
        imagesCarouselCollection.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        imagesCarouselCollection.frame = imagesCarouselCollection.bounds

//        addToCartBtn.layer.cornerRadius = 20
//        addToCartBtn.layer.masksToBounds = true
        buyNowBtn.layer.cornerRadius = 20
        buyNowBtn.layer.masksToBounds = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.imagesCarouselCollection.delegate = self
            self.imagesCarouselCollection.dataSource = self
            self.populatePage()
        }
    }

    @IBAction func buyNow(_ sender: Any) {
        customAlert.showBuyNowAlert(with: "Buy Now",
                                    on: self)
    }
    
//    @IBAction func addToCart(_ sender: Any) {
//        customAlert.showAlert(with: "Add To Cart",
//                              message: "Are you sure you didn't mean to hit Buy Now?",
//                              on: self)
//    }
    
    @objc func dismissAlert() {
        customAlert.dismissAlert()
    }

    func search(){
        resultsManager.getDetails(asinForSearch)
    }

    func createFeaturesLabels(featuresArray: [String]) -> String {
        var newFeatureString = ""
        for feature in featuresArray {
            newFeatureString.append(feature + "\n")
        }
        return newFeatureString
    }

    func populatePage(){
        if let productResults = self.productDeets {
            self.titleLabel.text = productResults.title
            self.desc.text = productResults.productDescription
            self.imagesArray = productDeets!.images
            self.features.text = createFeaturesLabels(featuresArray: productResults.featureBullets)
            self.price.text = "$" + String(productResults.price.currentPrice)
            self.starsLabel.text = productResults.reviews.rating + " out of 5 stars"
            self.noOfReviews.text = String(productResults.reviews.totalReviews) + " reviews"

            self.loadingIndicator.isAnimating = false
            self.stackedView.isHidden = false
        }
    }

    // MARK: - UI Setup for loading icon
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }

        self.stackedView.isHidden = true
        self.detailPageView.backgroundColor = .white

        self.detailPageView.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor
                .constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
    }

    // MARK: - Properties
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
}

extension ProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        let imageUrl = URL(string: imagesArray[indexPath.item])
        cell.configure(with: imageUrl!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension ProductViewController: ResultsDetailDelegate {
    func updateDetails(_ resultsManager: ResultsManager, products: Products) {
        self.productDeets = products
    }
}

//MARK: - AlertView object
class MyAlert: NSObject {
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.clipsToBounds = true
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    private var myTargetView: UIView?
    
    func showBuyNowAlert(with title: String,
                         on viewController: UIViewController){
        guard let targetView = viewController.view else {
            return
        }
        
        myTargetView = targetView
        
 //       removeAllSubviews(with: backgroundView)
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40,
                                 y: -300,
                                 width: targetView.frame.size.width-80,
                                 height: 300)
        
        let labelTitle = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: alertView.frame.size.width,
                                               height: 80))
        labelTitle.text = title
        labelTitle.textAlignment = .center
        alertView.addSubview(labelTitle)
        
//        let textfieldName = UITextField(frame: CGRect(x: 0,
//                                                  y: 100,
//                                                  width: alertView.frame.size.width * 0.75,
//                                                  height: 100))
//        textfieldName.placeholder = "Full Name"
//        textfieldName.layer.borderWidth = 1.0
//        textfieldName.centerXAnchor.constraint(equalTo: self.alertView.centerXAnchor).isActive = true
//        alertView.addSubview(textfieldName)
        
//        let textfieldAddress = UITextField(frame: CGRect(x: 0,
//                                                  y: 160,
//                                                  width: alertView.frame.size.width * 0.75,
//                                                  height: 50))
//        textfieldAddress.placeholder = "Full Address"
////        textfieldAddress.centerXAnchor.constraint(equalTo: self.alertView.centerXAnchor).isActive = true
//        alertView.addSubview(textfieldAddress)
//
//        let textfieldSSN = UITextField(frame: CGRect(x: 0,
//                                                  y: 220,
//                                                  width: alertView.frame.size.width * 0.75,
//                                                  height: 50))
//        textfieldSSN.placeholder = "Your social security number."
////        textfieldSSN.centerXAnchor.constraint(equalTo: self.alertView.centerXAnchor).isActive = true
//        alertView.addSubview(textfieldSSN)
        
        let dontWorryLabel = UILabel(frame: CGRect(x: 0,
                                                   y: 150,
                                                   width: alertView.frame.size.width,
                                                   height: 50))
        dontWorryLabel.text = "We have your location and credit card information. We're sending something now."
        dontWorryLabel.numberOfLines = 0
        dontWorryLabel.textAlignment = .center
        alertView.addSubview(dontWorryLabel)
        
        let dismissBtn = UIButton(frame: CGRect(x: 0,
                                            y: alertView.frame.size.height-50,
                                            width: alertView.frame.size.width,
                                            height: 50))
        dismissBtn.setTitle("Dismiss", for: .normal)
        dismissBtn.setTitleColor(.link, for: .normal)
        dismissBtn.addTarget(self,
                         action: #selector(dismissAlert),
                         for: .touchUpInside)
        alertView.addSubview(dismissBtn)
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self.backgroundView.alpha = Constants.backgroundAlphaTo
                       }, completion: { done in
                        if done {
                            UIView.animate(withDuration: 0.25, animations: {
                                self.alertView.center = targetView.center
                            })
                        }
                       })
    }
    
    func showAlert(with title: String,
                   message: String,
                   on viewController: UIViewController){
        guard let targetView = viewController.view else {
            return
        }
        
        myTargetView = targetView
        
        removeAllSubviews(with: backgroundView)
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40,
                                 y: -300,
                                 width: targetView.frame.size.width-80,
                                 height: 300)
        
        let labelTitle = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: alertView.frame.size.width,
                                               height: 80))
        labelTitle.text = title
        labelTitle.textAlignment = .center
        alertView.addSubview(labelTitle)
        
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                                 y: 80,
                                                 width: alertView.frame.size.width,
                                                 height: 170))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textAlignment = .left
        alertView.addSubview(messageLabel)
        
        let buyNowAlertBtn = UIButton(frame: CGRect(x: 0,
                                            y: alertView.frame.size.height-100,
                                            width: alertView.frame.size.width,
                                            height: 50))
        
        let dismissBtn = UIButton(frame: CGRect(x: 0,
                                            y: alertView.frame.size.height-50,
                                            width: alertView.frame.size.width,
                                            height: 50))
        dismissBtn.setTitle("Dismiss", for: .normal)
        dismissBtn.setTitleColor(.link, for: .normal)
        dismissBtn.addTarget(self,
                         action: #selector(dismissAlert),
                         for: .touchUpInside)
        alertView.addSubview(dismissBtn)
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self.backgroundView.alpha = Constants.backgroundAlphaTo
                       }, completion: { done in
                        if done {
                            UIView.animate(withDuration: 0.25, animations: {
                                self.alertView.center = targetView.center
                            })
                        }
                       })
    }
    
    @objc func dismissAlert(){
        
        guard let targetView = myTargetView else {
            return
        }
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self.alertView.frame = CGRect(x: 40,
                                                      y: targetView.frame.size.height,
                                                      width: targetView.frame.size.width-80,
                                                      height: 300)
                       }, completion: { done in
                        if done{
                            UIView.animate(withDuration: 0.25, animations: {
                                self.backgroundView.alpha = 0
                            }, completion: { done in
                                self.alertView.removeFromSuperview()
                                self.backgroundView.removeFromSuperview()
                            })
                        }
                       })
    }
    
    func removeAllSubviews(with backgroundView: UIView){
        backgroundView.subviews.forEach {$0.removeFromSuperview()}
    }
}

