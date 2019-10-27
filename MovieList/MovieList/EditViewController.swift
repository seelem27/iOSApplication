//
//  EditViewController.swift
//  Assignment_5
//
//  Created by See Lem on 28/08/2019.
//  Copyright © 2019 See Lem. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    var movieList = [Movie]()
    
    var selectedMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
            }
        
        appDelegate = delegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        //get the selected movie (assigned before transition)
        if let theMovie = selectedMovie {
            nameField.text = theMovie.name
            genreField.text = theMovie.genre
            priceField.text = "\(theMovie.price)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let price = Int(priceField.text!) {
            //selectedMovie.name = nameField.text!
            //selectedMovie.genre = genreField.text!
            //selectedMovie.price = Int16(price)
            selectedMovie.setValue(nameField.text, forKey: "name")
            selectedMovie.setValue(genreField.text, forKey: "genre")
            selectedMovie.setValue(price, forKey: "price")
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Status: Data save")
        } catch {
            print("Status. Could not save data")
        }
        
        
    }
}
