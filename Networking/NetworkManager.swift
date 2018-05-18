//
//  NetworkManager.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 3/26/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkManager {
    var totalPagesFromSearch = 0
    var totalResultsFromSearch = 0
    
    /// single movie item request based on movie id
    ///
    /// - Parameters:
    ///   - movieID: Movie id requested
    ///   - completion: single movie Item
    func getMovieFromMovieID(movieID: String, completion: @escaping (Movie?) -> Void) {
        
        Alamofire.request("\(Constants.URL.baseURLString)/movie/\(movieID)?api_key=\(Constants.API.key)")
            .responseJSON { response in
                
        
                guard response.result.isSuccess else {
                    print("Error while fetching Movie: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                guard let responseData = response.data else {
                    print("Invalid Movie information received from the service")
                    completion(nil)
                    return
                }
                
                
                
                do {
                    
                    let movie = try JSONDecoder().decode( Movie.self, from: responseData)
                    completion(movie)
                    
                } catch let error as NSError {
                    
                    print(error.localizedDescription)
                }
        
        }
    }
    
    

    /// Requests movies using query search
    ///
    /// - Parameters:
    ///   - query: query to be requested
    ///   - page: lets us move up/down page
    ///   - completion: array of movie items from request
    
    func movieSearch(query: String, page: Page, completion: @escaping ([Movie]?) -> Void) {
        
        var querySpaceReplaced = query.replacingOccurrences(of: " ", with: "%20")
        
        if querySpaceReplaced.suffix(3) != "%20"{
          querySpaceReplaced.append("%20")
        }
        
        Alamofire.request("\(Constants.URL.baseURLString)/search/movie?api_key=\(Constants.API.key)&query=\(querySpaceReplaced)&page=\(page.index)").responseJSON{ JSONresponse in
            
            guard JSONresponse.result.isSuccess else {
                print("Error while fetching Movie: \(String(describing: JSONresponse.result.error))")
                completion(nil)
                return
            }
//            print(JSONresponse)
            
            
            guard let responseData = JSONresponse.data else {
                print("Invalid Movie information received from the service")
                completion(nil)
                return
            }
            
            do {
                
                let search = try JSONDecoder().decode( Search.self, from: responseData)
                guard let totalPages = search.totalPages, let totalResults = search.totalResults else {
                    return
                }
            
                self.totalPagesFromSearch = totalPages
                self.totalResultsFromSearch = totalResults
                completion(search.results)
                
            } catch let error as NSError {
                
                print(error.localizedDescription)
                
            }  
        }
    }
}
