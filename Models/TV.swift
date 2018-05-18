//
//  TV.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 3/26/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import Foundation

struct TV: Decodable{
    
    var id: Int?
    var name: String?
    var numOfEpisodes: Int?
    var numOfSeasons: Int?
    var overview: String?
    var popularity: String?
    var posterPath: String?
    var genres: [Genre]?
    var seasons: [Season]?
    var voteAverage: Float?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case numOfEpisodes = "number_of_episodes"
        case numOfSeasons = "number_of_seasons"
        case overview
        case popularity
        case posterPath = "poster_path"
        case genres
        case seasons
        case voteAverage = "vote_average"
        
    }
    
    
}
