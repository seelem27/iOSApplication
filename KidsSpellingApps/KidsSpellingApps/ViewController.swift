//
//  ViewController.swift
//  Assignment2
//
//  Created by Guest User on 25/06/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //main page label
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeLabel1: UILabel!
    @IBOutlet weak var noticeLabel2: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var attempCountLabel: UILabel!
    
    //text field label
    @IBOutlet weak var answerTextField: UITextField!
    
    //button label
    @IBOutlet weak var restart_button: UIButton!
    @IBOutlet weak var next_button: UIButton!
    
    //label pop up
    @IBOutlet weak var messageLabel: UILabel!
    
    //spelling label
    @IBOutlet weak var spellingLabel: UILabel!
    
    //Images
    @IBOutlet weak var imageView: UIImageView!
    
    //initialize words
    let wordText = ["Apple", "Balloon", "Cat", "Dog", "Elephant", "Fish", "Glove", "Horse", "Ice", "Juice", "Kangaroo", "Lion", "Monkey", "Nurse", "Orange", "Penguin", "Queen", "Rat", "Shark", "Toy", "Umbrella", "Violin", "Watermelon", "Xylophone", "Yacht", "Zebra"]
    //initialize question into array
    let questions = ["Question 1", "Question 2", "Question 3" , "Question 4", "Question 5", "Question 6", "Question 7", "Question 8", "Question 9", "Question 10", "Question 11", "Question 12", "Question 13", "Question 14", "Question 15", "Question 16", "Question 17", "Question 18", "Question 19", "Question 20", "Question 21", "Question 22", "Question 23", "Question 24", "Question 25", "Question 26"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.isHidden = true
        next_button.isHidden = true
        restart_button.isHidden = true
        spellingLabel.isHidden = true
        answerTextField.delegate = self
        
        imageView.image = UIImage(named: "apple.jpeg")
        questionLabel.text = questions[index]
        correctAnswerLabel.text = "Score: \(correctAttempt) /26"
        attempCountLabel.text = "Attempt left: \(attemptCount)"
    }
    
    func textFieldShouldReturn(_ textField: UITextField)->Bool {
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }
    
    //initialize to default value
    var attempt : Int = 0
    var index = 0
    var correctAttempt = 0
    var attemptCount = 3
    
    //compare 2 string ignoring case sensitive
    func textFieldDidEndEditing(_ textField: UITextField) {
        if((wordText[index].caseInsensitiveCompare(answerTextField.text!)) == ComparisonResult.orderedSame)
        {
            if(index == 25) {
                next_button.isHidden = true
                restart_button.isHidden = false
            } else {
                next_button.isHidden = false
            }
            messageLabel.alpha = 1
            messageLabel.isHidden = false
            messageLabel.text = "Correct! Excellent"
            messageLabel.textColor = UIColor.green
            UIView.animate(withDuration: 5) {
                self.messageLabel.alpha = 0
            }
            answerTextField.isHidden = true
            attempt = 0
            correctAttempt += 1
            correctAnswerLabel.text = "Score: \(correctAttempt) /26"
        }
        else if ((attempt < 4) && ((wordText[index].caseInsensitiveCompare(answerTextField.text!) != ComparisonResult.orderedSame))) {
            messageLabel.alpha = 1
            attempCountLabel.text = "Attempt left: \(attemptCount)"
            messageLabel.isHidden = false
            messageLabel.text = "Please try again."
            messageLabel.textColor = UIColor.red
            UIView.animate(withDuration: 5) {
                self.messageLabel.alpha = 0
            }
            attempt += 1
            attemptCount -= 1
            attempCountLabel.text = "Attempt left: \(attemptCount)"
            if(attempt == 3){
                if(index == 25) {
                    next_button.isHidden = true
                    restart_button.isHidden = false
                } else {
                    next_button.isHidden = false
                }
                spellingLabel.isHidden = false
                spellingLabel.textColor = UIColor.red
                spellingLabel.text = wordText[index]
                answerTextField.isHidden = true
                
                attempt = 0
                attemptCount = 3
            }
        }
    }
    
    //button for next question
    @IBAction func nextButton(_ sender: UIButton) {
        index += 1
        attemptCount = 3
        attempCountLabel.text = "Attempt left: \(attemptCount)"
        questionLabel.text = questions[index]
        imageView.image = UIImage(named: wordText[index].lowercased())
        spellingLabel.isHidden = true
        answerTextField.isHidden = false
        next_button.isHidden = true
    }
    
    //restart button
    @IBAction func restartButton(_ sender: UIButton) {
        index = 0
        attempt = 0
        index = 0
        correctAttempt = 0
        attemptCount = 3
        attempCountLabel.text = "Attempt left: \(attemptCount)"
        questionLabel.text = questions[index]
        imageView.image = UIImage(named: wordText[index].lowercased())
        restart_button.isHidden = true
        answerTextField.isHidden = false
        spellingLabel.isHidden = true
    }
}

