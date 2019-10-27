//
//  AddViewController.swift
//  Assignment_5
//
//  Created by See Lem on 28/08/2019.
//  Copyright © 2019 See Lem. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    var appDelegate: AppDelegate!
    var manageContext: NSManagedObjectContext!
    
    var newMovie = [Movie]()
    var selectedMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate
            else{
                return
            }
        
        appDelegate = delegate
        manageContext = appDelegate.persistentContainer.viewContext
        
        if let theMovie = selectedMovie {
            nameField.text = theMovie.name
            genreField.text = theMovie.genre
            priceField.text = "\(theMovie.price)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //create a movie object
        let movie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: manageContext) as! Movie        
        
        if let price = Int(priceField.text!) {
            movie.name = nameField.text
            movie.genre = genreField.text
            movie.price = Int16(price)
        }
        
        do {
            try manageContext.save()
            print("Data save")
        } catch {
            print("Could not save data")
        }
        
        //append the new movie object to the array
        //newMovie.append(movie)
        
        let detailVC = segue.destination as! MasterTableViewController
        detailVC.newMovie = movie
    }
}
