//
//  Search.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 4/1/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import Foundation


struct Search: Decodable {
    
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results:[Movie]?
    
    enum CodingKeys: String,CodingKey {
        
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
