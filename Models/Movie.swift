//
//  Movie.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 3/26/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    var id: Int?
    var title: String?
    var overview: String?
    var releaseDate: String?
    var posterPath: String?
//    var popularity: Float?
    var genres: [Genre]?
    var voteAverage: Float?
    var runtime: Int?
    
    enum CodingKeys : String, CodingKey {
        
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
//        case popularity
        case genres
        case voteAverage = "vote_average"
        case runtime
    }
    
}
