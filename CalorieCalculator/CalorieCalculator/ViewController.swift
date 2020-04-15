//
//  ViewController.swift
//  CalorieCalculator
//
//  Created by Jorge Bejarano on 2020-04-01.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var calDisplay: UILabel!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var ageInput: UITextField!
    
    //male or female input
    /* TESTING
    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var femaleBtn: UIButton!
    */
    
    @IBOutlet var maleOrFemaleBtn: [UIButton]!
    
    
    //optional input
    //@IBOutlet weak var bodyFatInput: UITextField!
    
    //needed vars for calculations
    var height: String?
    var weight: String?
    var age: String?
    var mf: Bool?
    //optional inputs not implemented yet
    var fatPer: String?
    var fpIsThere: Bool = false
    
    //models implement
    var BMR = calorie()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Btn functions
    /*
    @IBAction func mPressed(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }else{
            sender.isSelected = true
            mf = true
            //print(mf)
        }
        
    }
    
    @IBAction func fPressed(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }else{
            sender.isSelected = true
            mf = false
            //print(mf)
        }
    }
    */
    
    @IBAction func genderSelected(_ sender: UIButton) {
        maleOrFemaleBtn.forEach({ $0.isSelected = false})
        
        sender.isSelected = true
        getGender()
    }
    
    func getGender(){
        for (index, button) in maleOrFemaleBtn.enumerated(){
            if button.isSelected == true {
                if index == 0 {
                    mf = true
                }else {
                    mf = false
                }
            }
        }
        print(mf!)
    }
    
    
    @IBAction func didPushBtn(_ sender: Any) {
        // calculate btn
        //grabbing info from UITextfields
        weight = weightInput.text
        height = heightInput.text
        age = ageInput.text
        //testing
        //mf = true //testing male cal
        //mf = false //testing female cal
        //testing
        //optional check
        /*
        if bodyFatInput.text != nil {
            fatPer = bodyFatInput.text
            fpIsThere = true
        }*/
        //convert to Doubles and Int
        let ageInt = Int(age!)!
        let weightD = (weight! as NSString).doubleValue
        let heightD = (height! as NSString).doubleValue
        //calculation
        let calculation = BMR.getBMR(weight: weightD, height: heightD, age: ageInt, gender: mf!)
        let cleanText = String(calculation)
        let cals = " cals"
        self.calDisplay.text = cleanText + cals
        
        //alert View
        let alertController = UIAlertController(title: "Notice", message: "Calculations For BMR were done using the Revised Harris-Benedict Equation", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true)
        
    }
    
}

