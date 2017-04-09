//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var businessesTableView: UITableView!
    
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        businessesTableView.dataSource = self
        businessesTableView.delegate = self
        businessesTableView.rowHeight = UITableViewAutomaticDimension
        businessesTableView.estimatedRowHeight = 80
        
        Business.searchWithTerm(term: "", completion: { (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                self.businessesTableView.reloadData()
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businesses {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        Business.searchWithTerm(term: searchText, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.businessesTableView.reloadData()
            }
        )
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        Business.searchWithTerm(term: "", completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.businessesTableView.reloadData()
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigationController = segue.destination as? UINavigationController {
            if let filtersViewController = navigationController.topViewController as? FiltersViewController {
                filtersViewController.delegate = self
            }
        }
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        // Offer
        let offeringDeal = filters["offeringDeal"] as! Bool
        
        // Categories
        let categories = filters["categories"] as? [String]

        // Sort
        let sortFilter = filters["sortFilter"] as? String
        
        var sort = YelpSortMode.bestMatched
        
        if let yelpSort = sortFilter {
            switch yelpSort {
            case "Distance":
                sort = YelpSortMode.distance
            case "Highest Rated":
                sort = YelpSortMode.highestRated
            default:
                sort = YelpSortMode.bestMatched
            }
        }
        
        // Distance
        var distance = 0
        if let distanceFilter = filters["distanceFilter"] as? String {
            switch distanceFilter {
            case "0.3 miles":
                distance = 482
            case "1 mile":
                distance = 1609
            case "5 miles":
                distance = 8046
            case "20 miles":
                distance = 32186
            default:
                distance = 0
            }
        }
        
        Business.searchWithTerm(term: "", sort: sort, categories: categories, deals: offeringDeal, distance: distance, completion: { (businesses: [Business]?, error: Error?) -> Void in

            self.businesses = businesses
            self.businessesTableView.reloadData()
        })
    }
}
