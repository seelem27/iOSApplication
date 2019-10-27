//
//  ViewController.swift
//  Assignment_5
//
//  Created by See Lem on 27/08/2019.
//  Copyright © 2019 See Lem. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var selectedMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //get the selected movie (assigned before transition)
        if let theMovie = selectedMovie {
            nameLabel.text = "Name: \(theMovie.name!)"
            genreLabel.text = "Genre: \(theMovie.genre!)"
            priceLabel.text = "Price (RM): \(theMovie.price)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get the view controller of the destination scene
        let editVC = segue.destination as! EditViewController
        
        //set selectedMovie property of the destination scene
        editVC.selectedMovie = selectedMovie
    }
    
    @IBAction func returnFromEdit(segue: UIStoryboardSegue) {
        //For testing purpose
        print("Returning from edit")
        
        nameLabel.text = "Name: \(selectedMovie.name!)"
        genreLabel.text = "Genre: \(selectedMovie.genre!)"
        priceLabel.text = "Price: \(selectedMovie.price)"
    }
}

