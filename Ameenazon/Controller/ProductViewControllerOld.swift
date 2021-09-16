////
////  ProductViewController.swift
////  Ameenazon
////
////  Created by Ameen Mustafa on 7/11/21.
////
//
//import UIKit
//import Kingfisher
//
//// make this look like amazon product page
//class ProductViewController1: UITableViewController {
//
//    var asinForSearch: String = ""
//    var resultsManager = ResultsManager()
//    var productDeets: Products!
//    var productsDetails = Array<Products>()
////    var productDeets: Products?
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        resultsManager.detailsDelegate = self
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UINib(nibName: "ImagesCell", bundle: nil), forCellReuseIdentifier: "imagesCell")
//        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
//        tableView.rowHeight = 750
////        resultsManager.getDetails(asinForSearch)
//        populateDetailsPage()
//
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        print(productsDetails.count)
//        return 3
//    }
//
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//////        if let productResults = productDeets {
////        let productResults = productDeets
////        print(productResults)
////        switch indexPath.row {
////        case 0:
////            let cell = tableView.dequeueReusableCell(withIdentifier: "imagesCell", for: indexPath) as! ImagesCell
//////                let url = URL(string: productResults[0].url)
//////              let urlString = String(productResults?.url)
//////                cell.imagioView.kf.setImage(with: url)
//////                cell.title.text = productResults[0].title
////            return cell
////        default:
////            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableViewCell
////
////            return cell
////        }
//    
////        }
////        print(productResults)
////        if indexPath.row == 0 {
////            let cell = tableView.dequeueReusableCell(withIdentifier: "imagesCell", for: indexPath) as! ImagesCell
////
////    //        cell.imagioView.loadImagesView(urlString: productResults.mainImage)
//// //           let url = URL(string: productResults?.url as! String)
//////            cell.imagioView.kf.setImage(with: url)
////            cell.title.text = productResults?.title
////            return cell
////        } else {
////            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableViewCell
////       //     cell.content.text = productDeets?.productDescription
////
////            return cell
////        }
//    }
//
//    func populateDetailsPage(){
//  //      resultsManager.getDetails(asinForSearch)
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//
//    func cellHeight(for indexPath: IndexPath) -> CGFloat {
//        let cell = self.tableView.cellForRow(at: indexPath)
//        return cell?.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height ?? 0
//    }
//}
//
////extension ProductViewController: ResultsDetailDelegate {
////    func updateDetails(_ resultsManager: ResultsManager, products: Products){
////        self.productsDetails.append(products)
////        self.productDeets = products
////        DispatchQueue.main.async {
////            self.tableView.reloadData()
////        }
////    }
////}
