//
//  ViewController.swift
//  popular-movies-tvOS
//
//  Created by Jose on 1/4/16.
//  Copyright © 2016 Rain Agency. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let BASE_URL = "https://api.themoviedb.org/3/movie/popular?api_key=1d91dec6e0faa67e8b7967a1c84b12e9"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadData()
    }
    
    // usually this wouldn't be implemented here, a download manager class should be created, but since this is just a test app, I decided to leave it here.
    func downloadData() {
        if let url = NSURL(string: BASE_URL) {
            let request = NSURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (data, response, error) ->
                Void in
                
                if error != nil {
                    print(error.debugDescription)
                } else {
                    do {
                        if let data = data {
                            let dict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? Dictionary<String, AnyObject>
                            if let results = dict?["results"] as? [Dictionary<String,AnyObject>] {
                                print(results)
                            }
                        }
                    } catch {
                        print("some error on JSON Serialization")
                    }
                }
                
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(352,546)
    }


}

