//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business]!
    var filteredBusinesses: [Business]!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Customize Navigation Bar
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
        
        //AutoLayout for TableView
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        //Initialize SearchBar
        filteredBusinesses = businesses
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        //API Call
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredBusinesses != nil {
            return filteredBusinesses!.count
        } else {
            return 0
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = filteredBusinesses[indexPath.row]
        //Customize cell appearance
        cell.selectionStyle = .None
        cell.accessoryType = .None
        
        return cell
    }
    

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //Get search text as string
        let searchText = searchController.searchBar.text
        
        //If search bar is active
        if searchController.active == true {
            //If no text is entered
            if searchText!.isEmpty {
                filteredBusinesses = businesses
            //As text is entered
            } else {
                //Filter businesses
                filteredBusinesses = businesses.filter { business in
                    if business.name!.rangeOfString(searchText!, options: .CaseInsensitiveSearch) != nil {
                        return true
                    } else {
                        return false
                    }
                }
            }
            tableView.reloadData()
        //If cancel button clicked
        } else {
            filteredBusinesses = businesses
            tableView.reloadData()
        }
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let business = filteredBusinesses![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailsViewController
        detailViewController.business = business
    }
    

}
