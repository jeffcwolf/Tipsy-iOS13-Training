//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!

    var tipPercent = 0.10
    var numberOfPeople = 2
    var billAmount = 0.0
    var finalResult = "0.0"

    @IBAction func tipChanged(_ sender: UIButton) {
        //Deselect all tip buttons
        
        billTextField.endEditing(true) //This is to dismiss the keyboard after using it
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //Highlight the button pressed
        sender.isSelected = true
        
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercent = buttonTitle.dropLast()
        let buttonTitleAsNumber = Double(buttonTitleMinusPercent)
         
        tipPercent = (buttonTitleAsNumber ?? 10) / 100
        
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
    
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    
    }
     
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        
        if bill != "" {
            billAmount = Double(bill)!
            let result = billAmount * (1 + tipPercent) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
        
        
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToResult" {
        let destinationVC = segue.destination as! ResultsViewController
        destinationVC.totalResult = finalResult
        destinationVC.tip = Int(tipPercent * 100)
        destinationVC.split = numberOfPeople
    }
    
    
    // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
    
}

}
