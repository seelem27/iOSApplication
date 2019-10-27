//
//  SecondViewController.swift
//  Assignment3
//
//  Created by Guest User on 12/07/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //label in the second view
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wordSelectedLabel: UILabel!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var wordNotFoundLabel: UILabel!
    
    //picker in the second view
    @IBOutlet weak var searchPicker: UIPickerView!
    
    //button
    @IBOutlet weak var selectButton: UIButton!
    
    var word = [String]()
    var userInput = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPicker.dataSource = self
        searchPicker.delegate = self
        
        //get the path for the property List file
        if let filePath = Bundle.main.path(forResource: "wordsList", ofType: "plist") {
            //get Data from the file
            if let plistData = FileManager.default.contents(atPath: filePath) {
                do {
                    //deserialize Data and return a property list
                    let plistObject = try PropertyListSerialization.propertyList(from: plistData, options: PropertyListSerialization.ReadOptions(), format: nil)
                    
                    //downcast the property list to an optional array of Strings
                    let words = plistObject as? [String]
                    
                    //print values of array
                    if let words = words {
                        for index in 0..<words.count {
                            if words[index].hasSuffix(userInput.lowercased()) {
                                word.append(words[index])
                            }
                        }
                    }
                } catch {
                    print("Error serializing data from property List")
                }
            } else {
                print("Error reading data from property list file")
            }
        } else {
            print("Property list file does not exists")
        }
        
        
        if word.count > 0 {
            searchResultLabel.text = word[0]
        }
        else {
           searchPicker.isHidden = true
            wordNotFoundLabel.text = "Word not found, search for another word"
            wordNotFoundLabel.textColor = UIColor.red
            selectButton.isHidden = true
        }
    }
    
    //picker view data source method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //picker view Data Source method
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return word.count
    }
    
    //Picker View Delegate method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return word[row]
    }
    
    //picker view delegate method
    //set the label based on the user selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        searchResultLabel.text = word[row]
    }
    
    @IBAction func wordSelectPressed(_ sender: UIButton) {
        //get the view controller object of the source scene for the segue
        let firstVC = presentingViewController as! FirstViewController
        
        //set the property in the view controller object of the source scene
        firstVC.searchWordLabel.text = searchResultLabel.text
        
        //Dismiss the second scene - Back to first scene
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cencelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
