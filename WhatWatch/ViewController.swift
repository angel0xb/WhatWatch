//
//  ViewController.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 3/26/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

class ViewController: UIViewController {
    

    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var randomButton: UIButton!
    let netManager = NetworkManager()
    let currentPage = Page()
    var myMovies = [Movie]()
    
    var currentResults = 0
    var totalResults = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: MovieTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.nibName)
        searchField.delegate = self
        
        randomButton.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /// updates the result label
    func updateNumOfResults() {
        currentResults = currentPage.index * 20
        
        if totalResults == 0 {
            totalResults = netManager.totalResultsFromSearch
        }
        if currentResults >= totalResults {
            currentResults = totalResults
        }

        resultsLabel.text = "results \(currentResults)/\(totalResults)"
    }
    
    func randomMovieFromArray(movies:[Movie]) -> (movie: Movie,randNum: Int)? {
        if movies.count <= 0 {
            return nil
        }
        for _ in currentPage.index..<netManager.totalPagesFromSearch {
            next(randomButton)
        }
        let randNum = Int(arc4random_uniform(UInt32(movies.count)))

        
        return (movies[randNum], randNum)
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(searchField)
        searchField.endEditing(true)
        return true
    }
}

///MARK: IBActions
extension ViewController {
    
    func scrollToTop() {
        if tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
        }
    }
    
    func scrollToBottom() {
        if tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0), at: UITableViewScrollPosition.top, animated: false)
        }
        
    }
    
    func refreshRows() {
        if tableView.numberOfRows(inSection: 0) > 3 {
            tableView.scrollToRow(at: IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0), at: UITableViewScrollPosition.top, animated: false)
            scrollToTop()
        }
        else {
            
            print("one")
        }
        
    }
    
    /// removes MovieView
    func removeRandomMovieView() {
        if let movieView = self.view.viewWithTag(100) {
            movieView.removeFromSuperview()
        } else {
            print("No View Found")
        }
    }
    
    
    
    ///  loads results from the nexts page
    @IBAction func next(_ sender: Any) {
        if currentPage.index <= netManager.totalPagesFromSearch {
            currentPage.up()
            netManager.movieSearch(query: searchField.text!, page: currentPage, completion:{
                movies in
                
                guard let movies = movies else{return}
                self.myMovies += movies
                self.tableView.reloadData()

            })
            updateNumOfResults()
        }
    }
    
    
    
    @IBAction func randomMovie(_ sender: Any) {
        
        totalResults -= 1
        removeRandomMovieView()
        let movieView = MovieView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width-50, height: self.view.frame.height - 150))
        
        if let randMovie = randomMovieFromArray(movies: myMovies) {
//            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.nibName, for: IndexPath(row: randMovie.randNum, section: 0)) as! MovieTableViewCell
            movieView.center = self.view.center
            movieView.tag = 100
//            print("\(movieView.center)   \(self.view.center)")
            movieView.populateMovieView(movie: randMovie.movie)
//            movieView.movieImage = cell.movieImageView
            updateNumOfResults()
            self.view.addSubview(movieView)
            
            myMovies.remove(at: randMovie.randNum)
            tableView.reloadData()
        } else {
            
            print("no movies")
        }

    }
    
    
    
    @IBAction func search(_ sender: Any) {
        print("searching")
        currentPage.reset()
        totalResults = 0
        currentResults = 0
        randomButton.isHidden = false
        removeRandomMovieView()

        
        netManager.movieSearch(query: searchField.text!, page: currentPage, completion:{
            movies in
            
            guard let movies = movies else{return}
            self.myMovies = movies
            self.updateNumOfResults()
            self.tableView.reloadData()
        })

        if searchField.text! == "" { //emtpy text clear tableView
            myMovies = []
            tableView.reloadData()
        }
    }
    
    
    @IBAction func searchOnChange(_ sender: Any) {
        print("on change searching")
        search(searchField)
        
    }
    
    
    @IBAction func searchFinished(_ sender: Any) {
        print("finished")
        search(searchField)
        
    }
    
    
    @IBAction func valChangeSearch(_ sender: Any) {
        search(searchField)
    }
    
}

///MARK: TableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return myMovies.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.nibName, for: indexPath) as! MovieTableViewCell
        let movie = myMovies[indexPath.row]
        cell.populateCellFromMovie(movie: movie)

        return cell
    }

}

///MARK: TableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
    
}
