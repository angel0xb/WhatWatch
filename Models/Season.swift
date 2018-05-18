//
//  Season.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 3/26/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import Foundation

struct Season: Decodable {
    
    var id: Int?
    var episodeCount: Int?
    var posterPath: String?
    var seasonNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case episodeCount = "episode_count"
        case posterPath = "poster_path"
        case seasonNumber = "sesason_number"
    }
}
