//
//  ViewController.swift
//  Assignment_4
//
//  Created by See Lem on 27/07/2019.
//  Copyright © 2019 See Lem. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //initialize english and malay into array type String
    var english = [String]()
    var malay = [String]()
    
    //Dictionary
    var words : [String: String] = [:]
    
    //table view
    @IBOutlet weak var tableView: UITableView!
    
    //labels
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var noResultLabel: UILabel!
    
    //text field
    @IBOutlet weak var wordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        wordTextField.delegate = self
        wordTextField.autocorrectionType = .no
        
        if let filePath = Bundle.main.path(forResource: "words", ofType: "plist") {
            if let plistData = FileManager.default.contents(atPath: filePath) {
                do {
                    let plistObject = try PropertyListSerialization.propertyList(from: plistData, options: PropertyListSerialization.ReadOptions(), format: nil)
                    
                    let words = plistObject as? [String: String]
                    
                    if let words = words {
                        for (key, value) in words {
                            english.append(key)
                            malay.append(value)
                        }
                    }
                }
                catch {
                    print("Error serializing data from property list")
                }
            } else {
                print("Error on retrieving data")
            }
        } else {
            print("Error on get the file location")
        }
        
        //store two array into a dictionary
        for (index, element) in english.enumerated() {
            words[element] = malay[index]
        }
    }
    
    //Table view Data Source method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Table view Data Source method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return english.count
    }
    
    //Table view Data Source method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        
        //take a cell from the queue of reusable cells
        cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        
        //if there are no reusable cells
        if cell == nil {
            cell = UITableViewCell(style:.value1, reuseIdentifier: "tableCell")
        }
        
        //set the textLabel for the cell
        cell!.textLabel!.text = english[indexPath.row]
        cell!.detailTextLabel!.text = malay[indexPath.row]
        
        //create the images
        let image = UIImage(named: "round")
        let highlightedImage = UIImage(named: "mark")
        
        //assign the images to cell properties
        cell!.imageView?.image = image
        cell!.imageView?.highlightedImage = highlightedImage
        
        //return the table view cell
        return cell!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        wordTextField.text = ""
    }
    
    @IBAction func searchWordButton(_ sender: UIButton) {
        if (wordTextField.text == "") {
            let alertController = UIAlertController(
                title:"No input",
                message: "Please enter word into the text field",
                preferredStyle: UIAlertControllerStyle.alert)
            
            //create a UIAlertAction object for the alert
            let cancelAction = UIAlertAction(
                title:"Cancel",
                style:UIAlertActionStyle.cancel,
                handler:nil)
            
            //add the UIAction to the UIAlertController
            alertController.addAction(cancelAction)
            
            //present or display the alert
            self.present(alertController, animated: true, completion: nil)
        }
        
        if (Int(wordTextField.text!) != nil) {
            let alertController = UIAlertController(
                title:"Number input",
                message: "Please enter word into the text field",
                preferredStyle: UIAlertControllerStyle.alert)
            
            
            //create a UIAlertAction object for the alert
            let cancelAction = UIAlertAction(
                title:"Cancel",
                style:UIAlertActionStyle.cancel,
                handler:nil)
            
            //add the UIAction to the UIAlertController
            alertController.addAction(cancelAction)
            
            //present or display the alert
            self.present(alertController, animated: true, completion: nil)
        }
        
        for (englishWord) in words.keys {
            if words[wordTextField.text!] != nil {
                if(englishWord.contains(wordTextField.text!.lowercased())) {
                    resultLabel.text! = words[englishWord]!
                }
            } else {
                let alertController = UIAlertController(
                    title:"Word not exist in the dictionary",
                    message:"Please enter another word into the text field",
                    preferredStyle: UIAlertControllerStyle.alert)
                
                //create an UIAlertAction object for the alert
                let cancelAction = UIAlertAction(
                    title:"Cancel",
                    style:UIAlertActionStyle.cancel,
                    handler:nil)
                
                //add the UIAction to the UIAlertController
                alertController.addAction(cancelAction)
                
                //present or display the alert
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
