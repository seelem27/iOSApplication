//
//  ViewController.swift
//  Assignment_6
//
//  Created by See Lem on 29/08/2019.
//  Copyright © 2019 See Lem. All rights reserved.
//

import UIKit
import AVFoundation  //for AVAudioPlayer

class DetailViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var audioTitleLabel: UILabel!
    @IBOutlet weak var lastPlayed: UITextField!
    @IBOutlet weak var saveLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
    var selectedAudio: Audio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get access to user settings using singleton NSUserDefaults
        let defaults = UserDefaults.standard
        
        let bells = URL(fileURLWithPath: Bundle.main.path(forResource: "bells", ofType: "mp3")!)
        
        let guitar = URL(fileURLWithPath: Bundle.main.path(forResource: "guitar", ofType: "mp3")!)
        
        let keyboard = URL(fileURLWithPath: Bundle.main.path(forResource: "keyboard", ofType: "mp3")!)
        
        let piano = URL(fileURLWithPath: Bundle.main.path(forResource: "piano", ofType: "mp3")!)
        
        if let played = defaults.string(forKey: "lastPlayed") {
            saveLabel.text! = played
        }
        
        //get the selected audio(assigned before transition)
        if let theAudio = selectedAudio {
            audioTitleLabel.text = "\(theAudio.title)"
            
            if(theAudio.title == NSLocalizedString("audio-title1", comment: "Bells")) {
                print("play bells")
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: bells)
                    audioPlayer!.delegate = self
                    audioPlayer!.prepareToPlay()
                } catch let error as NSError {
                    print("audioPlayer error \(error.localizedDescription)")
                }
            }
            
            if(theAudio.title == NSLocalizedString("audio-title2", comment: "Guitar")) {
                print("play guitar")
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: guitar)
                    audioPlayer!.delegate = self
                    audioPlayer!.prepareToPlay()
                } catch let error as NSError {
                    print("audioPlayer error \(error.localizedDescription)")
                }
            }
            
            if(theAudio.title == NSLocalizedString("audio-title3", comment: "Keyboard")) {
                print("play keyboard")
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: keyboard)
                    audioPlayer!.delegate = self
                    audioPlayer!.prepareToPlay()
                } catch let error as NSError {
                    print("audioPlayer error \(error.localizedDescription)")
                }
            }
            
            if(theAudio.title == NSLocalizedString("audio-title4", comment: "Piano")) {
                print("play piano")
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: piano)
                    audioPlayer!.delegate = self
                    audioPlayer!.prepareToPlay()
                } catch let error as NSError {
                    print("audioPlayer error \(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func play(_ sender: UIButton) {
        if let player = audioPlayer {
            player.play()
        }
        
        //get access to user settings using singleton NSUserDefaults
        let defaults = UserDefaults.standard
        
        //save the last played
        defaults.setValue(lastPlayed.text, forKey: "played")
    }
    
    @IBAction func stop(_ sender: UIButton) {
        if let player = audioPlayer {
            player.stop()
        }
        
        //get access to user settings using singleton NSUserDefaults
        let defaults = UserDefaults.standard
        
        //save the last played
        defaults.setValue(lastPlayed.text, forKey: "played")
    }
}

