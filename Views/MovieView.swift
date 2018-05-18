//
//  MovieView.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 5/11/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import UIKit

class MovieView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genres: UITextView!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var runtime: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        Bundle.main.loadNibNamed("MovieView", owner: self, options: nil)
        
//        contentView.backgroundColor = UIColor.gray
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
    func populateMovieView(movie: Movie) {
        movieTitle.text = movie.title
        releaseDate.text = movie.releaseDate
        rating.text = "\(String(describing: movie.voteAverage!))/10⭐️'s"
        overview.text = movie.overview
        genres.text = genreArrayToText(genres: movie.genres)
        runtime.text = "\(movie.runtime ?? 0 )" 
        guard let posterPath = movie.posterPath else { return }
        guard let url = URL(string: "\(Constants.URL.posterBaseUrl)\(posterPath)") as URL?  else {
            print("\(Constants.URL.posterBaseUrl)\(posterPath)")
            
            return
        }
        
        movieImage.loadImageUsingCacheWithUrl(url: url, completion:{_ in })

    }
    
    func genreArrayToText(genres: [Genre]?) -> String{
        guard  let genres = genres  else {return ""}
        var genresString = ""
        for genre in genres {
            if let genreName = genre.name{
                genresString.append("\(genreName), ")
            } else {
                
            }
        }
        return genresString
    }
    
    func addRandomMovie(randMovie: Movie) -> MovieView {
        let movieView = MovieView()
//        let randMovie = randomMovieFromArray(movies: myMovies)
        movieView.tag = 100
        movieView.movieTitle.text = randMovie.title!
        return movieView
    }
}
