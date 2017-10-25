//  ViewController.swift
//  BullsEye
//
//  Created by Ken Kotch on 10/24/17.
//  Copyright © 2017 ken. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var round = 0
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewRound()
    }
    
    func updateLables() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLables()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        print("the value of slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points: Int = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "PERFECT! 100 Bonus Points!"
            points += 100
        } else if difference == 1 {
            title = "One away! 50 Bonus Points!"
            points += 50
        } else if difference < 5 {
            title = "SOOO Close."
        } else if difference < 15 {
            title = "Not Terrible."
        } else {
            title = "You need to try harder!"
        }
        
        score += points
        
        let message = "You scored \(points) points."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func restart() {
        startNewRound()
        round = 1
        score = 0
        scoreLabel.text = String(0)
        roundLabel.text = String(0)
    }
    
    
}

