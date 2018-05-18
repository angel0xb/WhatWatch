//
//  MovieTableViewCell.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 5/8/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
//    var id: Int?

//    var posterPath: String?
//    //    var popularity: Float?
//    var genres: [Genre]?
    
    static let nibName = "MovieTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextField: UITextView!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    /// Populates all cell IBoutlets, downloads image
    ///
    /// - Parameter movie: Movie used to populate the cell
    func populateCellFromMovie(movie: Movie){
        
        accessoryType = .disclosureIndicator
        self.imageIndicator.startAnimating()

        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        voteAverageLabel.text = "\(String(describing: movie.voteAverage!))/10⭐️'s"
        overviewTextField.text = movie.overview
        
        guard let posterPath = movie.posterPath else { return }
        guard let url = URL(string: "\(Constants.URL.posterBaseUrl)\(posterPath)") as URL?  else {
            print("\(Constants.URL.posterBaseUrl)\(posterPath)")
            
            return
        }
        
        movieImageView.loadImageUsingCacheWithUrl(url: url , completion:{
            (success) in
            if success {
                self.imageIndicator.stopAnimating()
            }
        })
    }
    
    
}
