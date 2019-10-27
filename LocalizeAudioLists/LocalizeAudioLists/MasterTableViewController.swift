//
//  MasterTableViewController.swift
//  Assignment_6
//
//  Created by See Lem on 29/08/2019.
//  Copyright © 2019 See Lem. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    //array to store the audio objects
    var audios = [Audio]()
    
    override func viewDidLoad() {
        // create 4 Audio objects
        let audio1 = Audio(title: NSLocalizedString("audio-title1", comment: "Bells"))
        let audio2 = Audio(title: NSLocalizedString("audio-title2", comment: "Guitar"))
        let audio3 = Audio(title: NSLocalizedString("audio-title3", comment: "Keyboard"))
        let audio4 = Audio(title: NSLocalizedString("audio-title4", comment: "Piano"))
        
        //append the 4 objects to the array
        audios.append(audio1)
        audios.append(audio2)
        audios.append(audio3)
        audios.append(audio4)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get the index path of the row selected in the table
        if let indexPath = tableView.indexPathForSelectedRow {
            
            //get the view controller of the destination scene
            let detailVC = segue.destination as! DetailViewController
            
            //set the selected audio property of the destination scene
            detailVC.selectedAudio = audios[indexPath.row]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audios.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        //the identifier name must be the same as the one set earlier
        cell = tableView.dequeueReusableCell(withIdentifier: "AudioCell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "AudioCell")
        }
        
        cell!.textLabel!.text = audios[indexPath.row].title
        
        return cell!
    }
}
