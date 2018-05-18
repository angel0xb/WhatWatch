//
//  MovieTitleCell.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 5/14/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import UIKit

class MovieTitleCell: UITableViewCell {
    
    static let nibName = "MovieTitleCell"
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}
