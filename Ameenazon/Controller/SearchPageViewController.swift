//
//  ViewController.swift
//  Ameenazon
//
//  Created by Ameen Mustafa on 7/11/21.
//

import UIKit

class SearchPageViewController: UITableViewController {

    var resultsManager = ResultsManager()
    var searchedText: String = ""
    var results = ResultsPage()

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSearchResults", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSearchResults") {
            let destinationVC = segue.destination as! ResultsPageTableViewController
            destinationVC.searchedText = searchedText
        }
    }
    
    
}

// the searching code goes here
// searching code can be found in amazon api
extension SearchPageViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.searchBar.text!.count > 0 {
            searchedText = self.searchBar.text!
            self.performSegue(withIdentifier: "toSearchResults", sender: self)
        }
    }
}
