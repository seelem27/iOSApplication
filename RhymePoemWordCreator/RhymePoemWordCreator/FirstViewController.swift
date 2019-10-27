//
//  ViewController.swift
//  Assignment3
//
//  Created by Guest User on 12/07/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    //labels and textFields in first view controller
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var searchWordLabel: UILabel!
    @IBOutlet weak var textViewBox: UITextView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchWordsTitleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = self
        textViewBox.autocorrectionType = .no
        textField.autocorrectionType = .no
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (textField.text == "") {
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
        
        if (Int(textField.text!) != nil) {
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
        
        //get the view controller object of the destination scene for this segue
        let secondVC = segue.destination as! SecondViewController
            
        //access the property in the view controller object of the destination scene
        secondVC.userInput = textField.text!
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Clear the previous input to "" when begin editting
        textField.text = ""
    }
}

