//
//  DetailsViewController.swift
//  Yelp
//
//  Created by user116136 on 2/6/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var address3Label: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fill labels with business data
        titleLabel.text = business.name
        restaurantImageView.setImageWithURL(business.imageURL!)
        addressLabel.text = business.address1
        address2Label.text = business.address2
        address3Label.text = business.address3
        reviewCountLabel.text = "\(business.reviewCount!)"
        ratingImageView.setImageWithURL(business.ratingImageURL!)
        distanceLabel.text = business.distance
        reviewImageView.setImageWithURL(business.snippetImageURL!)
        reviewLabel.text = business.snippetText
        phoneLabel.text = business.phone
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view

    }
    

}
