//
//  ResultsManager.swift
//  Ameenazon
//
//  Created by Ameen Mustafa on 7/15/21.
//

import Foundation

protocol ResultsManagerDelegate {
    func updateResults(_ resultsManager: ResultsManager, product: Product)
}

protocol ResultsDetailDelegate {
    func updateDetails(_ resultsManager: ResultsManager, products: Products)
}

class ResultsManager {
    
    var delegate: ResultsManagerDelegate?
    var detailsDelegate: ResultsDetailDelegate?
    var reqeustURL = "https://amazon-product-reviews-keywords.p.rapidapi.com/product/search?keyword="
    var detailRequest = "https://amazon-product-reviews-keywords.p.rapidapi.com/product/details?asin="
    var results = ResultsPage()
    let params = ["x-rapidapi-key":"98c2784820msh1aef1af91e59944p169722jsn9feeceae1f3e", "x-rapidapi-host": "amazon-product-reviews-keywords.p.rapidapi.com"]
    
    
    func getProducts(_ searchText: String) {
        
        let search = "\(reqeustURL)\(searchText)&country=US&category=aps"
        var request = URLRequest(url: URL(string: search)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = params
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error -> Void in
        if let jsonData = data {
            do {
                let root = try JSONDecoder().decode(ProductSearch.self, from: jsonData)
                root.products.forEach{(element) in
                    if let product = self.parseJSON(element){
                        self.delegate?.updateResults(self, product: product)
                    }
                }
            } catch {
                print(error)
            }
            }
        }
        task.resume()
    }
    
    func getDetails(_ asin: String) {
        let search = "\(detailRequest)\(asin)&country=US"
        var request = URLRequest(url: URL(string: search)!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = params
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error -> Void in
            guard let self = self else { return }
        
            if let jsonData = data {
                do {
                    let productDetail = try JSONDecoder().decode(ProductDetail.self, from: jsonData)
                    let products = productDetail.product
                    self.detailsDelegate?.updateDetails(self, products: products)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ safeData: Product) -> Product? {
        
        do {
            let product = Product(asin: safeData.asin, price: safeData.price, reviews: safeData.reviews, url: safeData.url, amazonPrime: safeData.amazonPrime, title: safeData.title, thumbnail: safeData.thumbnail)
                return product
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
