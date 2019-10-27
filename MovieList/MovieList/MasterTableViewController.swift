//
//  MasterTableViewController.swift
//  Assignment_5
//
//  Created by See Lem on 27/08/2019.
//  Copyright © 2019 See Lem. All rights reserved.
//

import UIKit
import CoreData

class MasterTableViewController: UITableViewController {
    
    //array to store the Movie objects
    var movieList = [Movie]()
    
    var newMovie: Movie!
    
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    var foundMovie: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate
            else {
                print("Status: Error in app")
                return
            }
        
        appDelegate = delegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        //call fetchRequest() method in Movie class to obtain a fetchRequest
        let fetchRequest :NSFetchRequest<Movie> = Movie.fetchRequest()
        
        //retrieve all the Movie object data from the database and store in array of movie object
        do {
            movieList = try managedContext.fetch(fetchRequest)
        } catch {
            print("Error retrieving data")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MovieCell")
        }
        
        cell!.textLabel!.text = movieList[indexPath.row].name
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toDetail" {
                //get the index of the row selected in the table
                if let indexPath = tableView.indexPathForSelectedRow {
                    //get the view controller of the destination scene
                    let detailVC = segue.destination as! DetailViewController
                    
                    //set the selectedMovie property of the destination scene
                    detailVC.selectedMovie = movieList[indexPath.row]
                }
            } else if identifier == "toAdd" {
                newMovie = nil
            }
        }
    }
    
    @IBAction func returnFromAdd(segue: UIStoryboardSegue) {
        movieList.append(newMovie)
        let indexPath = IndexPath(row: movieList.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete row from array
            //movieList.remove(at: indexPath.row)
            
            //managedContext.delete()
            managedContext.delete(movieList.remove(at: indexPath.row))
            
            do {
                try managedContext.save()
                print("Status: Data saved")
            } catch {
                print("Status: Could not save data")
            }
            
            //delete row from table view
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
