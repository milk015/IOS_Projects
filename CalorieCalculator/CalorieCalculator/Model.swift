//
//  Model.swift
//  CalorieCalculator
//
//  Created by Jorge Bejarano on 2020-04-01.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

import Foundation

class calorie{
    var weight: Double = 0.0
    var height: Double = 0.0
    var age: Int = 0
    var gender:Bool = true;
    
    init() {
        //setting defaults 0's and male
        weight = 0.0
        height = 0.0
        age = 0
        gender = true//m=t,f=f
    }
    //Revised Harris-Benedict Equation
    //Men BMR = 13.397W + 4.799H - 5.677A + 88.362
    //Women BMR = 9.247W + 3.098H - 4.330A + 447.593
    func getBMR(weight: Double, height: Double, age: Int, gender: Bool)->Int{
        //needed for func vars
        var BMR = 0
        var weightCalculation = 0.0
        var heightCalculation = 0.0
        var ageCalculaition = 0.0
        
        if gender == true { //male
            weightCalculation = 13.397 * weight
            heightCalculation = 4.799 * height
            ageCalculaition = 5.677 * Double(age)
            
            BMR = Int(88.362 + weightCalculation  + heightCalculation - ageCalculaition)
            
            return Int(BMR)
        }
        
        else { //female
            weightCalculation = 9.247 * weight
            heightCalculation = 3.098 * height
            ageCalculaition = 4.330 * Double(age)
            
            BMR = Int(447.593 + weightCalculation  + heightCalculation - ageCalculaition)
            
            return Int(BMR)
        }
        
    }
    
}
