//
//  ViewController.swift
//  Math Solver
//
//  Created by Нуртау on 12/18/20.
//

import UIKit
import SwiftyTimer

protocol ViewControllerDelegate {
    func restoreData()
    func restoreTimer()
}

class ViewController: UIViewController, MathManagerProtocol {
    
    var maxNumber: Int?
    var operations: Set<Int>?
    let mathManager = MathManager()
    var timerVariable = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    func returnTimer() -> Timer {
        return Timer.new(every: 1.second) { (timer: Timer) in
            self.timerVariable += 1
            self.timerLabel.text = "Timer: \(self.timerVariable) s"
            if self.timerVariable == 60 {
                timer.invalidate()
                self.timerVariable = 0
                self.performSegue(withIdentifier: "goToResult", sender: self)
            }
        }
    }
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        mathManager.delegate = self
        mathManager.answered("1", max: maxNumber!, operations: operations!)
        timer = returnTimer()
        timer?.start(modes: .default)
    }

    func updateUI(score: Int, answerOptions: [Int], question: String){
        scoreLabel.text = "Score: \(score)"
        firstOption.setTitle("\(answerOptions[0])", for: .normal)
        secondOption.setTitle("\(answerOptions[1])", for: .normal)
        thirdOption.setTitle("\(answerOptions[2])", for: .normal)
        fourthOption.setTitle("\(answerOptions[3])", for: .normal)
        questionLabel.text = question
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        mathManager.answered(sender.currentTitle!, max: maxNumber!, operations: operations!)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restartPressed(_ sender: UIButton) {
        restoreData()
        restoreTimer()
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.delegate = self
            resultVC.resultingScore = mathManager.score
        }
    }
}




//MARK: - ViewControllerDelegate

extension ViewController: ViewControllerDelegate {
    func restoreData() {
        self.timerVariable = 0
        self.timerLabel.text = "Timer: 0 s"
        self.scoreLabel.text = "Score: 0"
        self.mathManager.score = 0
        mathManager.answered("1111", max: maxNumber!, operations: operations!)
    }
    func restoreTimer(){
        timer?.invalidate()
        timer = returnTimer()
        timer?.start(modes: .default)
    }
}

