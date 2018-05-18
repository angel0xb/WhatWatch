//
//  Constants.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 3/26/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    ///API Key canstant
    struct API {
        
        static let key = "f2544191223b825d6fd93e94a12b5cae"
        
    }
    
    ///URL Constants
    struct URL {
        
        static let baseURLString = "https://api.themoviedb.org/3"
        static let posterBaseUrl = "http://image.tmdb.org/t/p/w185"
    }
    
    /// No Image constant
    struct Image {
        
        static let noPhoto = UIImage(named: "noPhoto")!
    }
}
