//
//  Movie.swift
//  popular-movies-tvOS
//
//  Created by Jose on 1/4/16.
//  Copyright © 2016 Rain Agency. All rights reserved.
//

import Foundation

class Movie {
    let BASE_URL = "http://image.tmdb.org/t/p/w500"
    
    var title: String!
    var overview: String!
    var posterPath: String!
    
    init(movieDict: Dictionary<String, AnyObject>) {
        if let title = movieDict["title"] as? String, overview = movieDict["overview"] as? String, path = movieDict["poster_path"] as? String  {
            self.title = title
            self.overview = overview
            self.posterPath = "\(BASE_URL)\(path)"
        }
        
    }
}