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
    
    var movies = [Movie]()
    //258,355
    let defaultSize = CGSize(width: 315, height: 500)
    let focusSize = CGSize(width: 345, height: 550 )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
                                for obj in results {
                                    let movie = Movie(movieDict: obj)
                                    self.movies.append(movie)
                                }
                                
                                // since we are calling the main thread from a background process whe mus use weak self to avoid a  retain cycle
                                dispatch_async(dispatch_get_main_queue()) { [weak self] in
                                    self?.collectionView.reloadData()
                                }
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
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell {
            let movie = movies[indexPath.row]
            cell.configureCell(movie)
            
            return cell
        }
        
        return MovieCell()
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return defaultSize
    }


    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let previous = context.previouslyFocusedView as? MovieCell {
            UIView.animateWithDuration(0.1, animations: {() -> Void in
                previous.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? MovieCell {
            UIView.animateWithDuration(0.1, animations: {() -> Void in
                next.frame.size = self.focusSize
            })
        }
    }
}

