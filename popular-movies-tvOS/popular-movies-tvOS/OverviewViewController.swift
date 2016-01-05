//
//  OverviewViewController.swift
//  popular-movies-tvOS
//
//  Created by Jose on 1/5/16.
//  Copyright © 2016 Rain Agency. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTite: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var image: UIImage?
    var overview: String?
    var movie: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = image, overview = overview {
            movieImage.image = image
            movieOverview.text = overview
            movieTite.text = movie
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
