//
//  SettingsViewController.swift
//  Math Solver
//
//  Created by Нуртау on 12/21/20.
//

import UIKit

class SettingsViewController: UIViewController {
    var operations = Set<Int>()
    
    @IBOutlet weak var maxNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func startPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    
    //switchHandler
    func switchHandler(_ sender: UISwitch, n: Int) {
        if sender.isOn == true {
            operations.insert(n)
        } else {
            operations.remove(n)
        }
    }
    //addition
    @IBAction func additionSwitch(_ sender: UISwitch) {
        switchHandler(sender, n: 0)
    }
    
    //substraction
    @IBAction func substractionSwitch(_ sender: UISwitch) {
        switchHandler(sender, n: 1)
    }
    
    //multiplication
    
    @IBAction func multiplicationSwitch(_ sender: UISwitch) {
        switchHandler(sender, n: 2)
    }
    
    //division
    
    @IBAction func divisionSwitch(_ sender: UISwitch) {
        switchHandler(sender, n: 3)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameVC = segue.destination as! ViewController
        if maxNumber.text != ""{
            let selectedNumber = Int(maxNumber.text!)
            if selectedNumber! >= 10 {
                gameVC.maxNumber = Int(maxNumber.text!)
            } else if selectedNumber! < 10 {
                gameVC.maxNumber = 10
            } else {
                gameVC.maxNumber = 100
            }
        } else {
            gameVC.maxNumber = 100
        }
        if operations.count == 0 {
            gameVC.operations = [0]
        } else {
            gameVC.operations = operations
        }
    }
    
    
    
    
    
  

}
