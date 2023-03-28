//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tip = 0.0
    var numberOfPeople = 2
    var totalBill = 0.0
    var resultBill = 0.0
    var textTip = ""
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroBctButton: UIButton!
    @IBOutlet weak var tenBctButton: UIButton!
    @IBOutlet weak var twentyBctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroBctButton.isSelected = false
        tenBctButton.isSelected = false
        twentyBctButton.isSelected = false
        sender.isSelected = true
        let buttonTitle = sender.currentTitle!
        textTip = buttonTitle
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsANumber / 100
        let currentBill = billTextField.text ?? "0.0"
        totalBill = (currentBill as NSString).doubleValue
        
        
        
        
    }
    
    @IBAction func stepValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
        numberOfPeople = Int(sender.value)
        
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billWithTip = totalBill + (totalBill * tip)
        resultBill = billWithTip / Double(numberOfPeople)
        print(round(resultBill * 100) / 100.0)
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destination = segue.destination as! ResultsViewController
            destination.resultLabel = String(format: "%.2f", resultBill)
            destination.text = "Split between \(numberOfPeople) people with \(textTip) tip"
        }
    }
}
