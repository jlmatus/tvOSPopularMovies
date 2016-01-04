//
//  MovieCell.swift
//  popular-movies-tvOS
//
//  Created by Jose on 1/4/16.
//  Copyright © 2016 Rain Agency. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitel: UILabel!
 
    func configureCell(movie: Movie) {
        if let title = movie.title, path = movie.posterPath {
            movieTitel.text = title
            let url = NSURL(string: path)
            if let url = url {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    let data = NSData(contentsOfURL: url)
                    if let data = data, image = UIImage(data: data) {
                        dispatch_async(dispatch_get_main_queue()) { [weak self] in
                            self?.movieImage.image = image
                        }
                    }
                    
                }
            }
        }
    }
}
