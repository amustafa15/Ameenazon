//
//  ResultsPageTableViewController.swift
//  Ameenazon
//
//  Created by Ameen Mustafa on 7/28/21.
//

import UIKit
import Kingfisher

class ResultsPageTableViewController: UITableViewController {
    
    var searchedText: String = ""
    var asinForSearch: String = ""
    
    @IBOutlet var resultsTableView: UITableView!
    var resultsArray = Array<Product>()
    {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var resultsManager = ResultsManager()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        resultsManager.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchPageResultsCell", bundle: nil), forCellReuseIdentifier: "searchResultCell")
        
        tableView.rowHeight = 175
        populateResults()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        asinForSearch = resultsArray[indexPath.row].asin
        self.performSegue(withIdentifier: "toProductPage", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toProductPage"){
            let destinationVC = segue.destination as! ProductViewController
            destinationVC.asinForSearch = asinForSearch
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = resultsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchPageResultsCell
        
//        cell.productImage.load(urlString: searchResult.thumbnail)
        let url = URL(string: searchResult.thumbnail)
        cell.productImage.kf.setImage(with: url)
        cell.titleLabel.text = searchResult.title
        cell.ratingLabel.text = String(searchResult.reviews.rating) + "/5 stars"
        cell.reviewsLabel.text = String(searchResult.reviews.totalReviews) + " reviews"
        cell.priceLabel.text = "$" + String(searchResult.price.currentPrice)
        if searchResult.amazonPrime == true {
            cell.isPrimeEligibleLabel.text = "Prime Eligible!"
        } else {
            cell.isPrimeEligibleLabel.isHidden = true
        }
        
        return cell
    }
    
    func populateResults(){
        resultsManager.getProducts(searchedText)
    }
}

//MARK: - ResultsManagerDelegate

extension ResultsPageTableViewController: ResultsManagerDelegate {
    func updateResults(_ resultsManager: ResultsManager, product: Product){
            self.resultsArray.append(product)
    }
}
