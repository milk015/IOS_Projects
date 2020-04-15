//
//  detailViewController.swift
//  MAPAssignment2-current
//
//  Created by Jorge Bejarano on 2020-04-09.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class detailViewController: UIViewController,getWeatherDelegate {
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var humidLabel: UILabel!
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    lazy var weatherData = NSDictionary()
    lazy var weatherLib = weatherApi()
    
    var detailViewDelegate = ""
    
    var temp = ""
    var humid = ""
    
    var updateTimer: Timer?
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = detailViewDelegate
        weatherLib.delegate = self
        print(detailViewDelegate)
        //print(weatherData,"didload")
        //self.humidLabel.text = humid
        // Do any additional setup after loading the view.
        
        //Update temp every 10 seconds
        updateTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) {
            timer in
            let t = self.weatherData.value(forKeyPath: "temp") as? Double
            let h = self.weatherData.value(forKeyPath: "humidity") as? Double
            self.temp = NSString(format: "%.1f", t!) as String
            self.humid = NSString(format: "%.1f", h!) as String
            self.tempLabel.text = self.temp
            self.humidLabel.text = self.humid
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        getData(city: detailViewDelegate)
        
        /*
        var loopSet = false
        if (detailViewDelegate != nil) {
            weatherLib.getWeatherData(city: detailViewDelegate)
            while (loopSet == false){
                if (temp == "" && humid == "") {
                    var t = weatherData.value(forKeyPath: "main.temp")
                    var h = weatherData.value(forKeyPath: "main.humidity")
                    if (t == nil && h == nil){
                        print("Wating....")
                    }else{
                        temp = t as? String ?? "Error"
                        humid = h as? String ?? "Error"
                    }
                }else {
                    loopSet = true
                }
            }
        }
        print(weatherData,"viewWillAppear")
 */
    }
    
    func weatherWasRecieved(data: NSDictionary) {
        weatherData = data
        print("Recieved",weatherData)
    }
    
    func getData(city: String){
        weatherLib.getWeatherData(city: city)
        print(weatherData, "GetData")
        //let detailGrab = weatherData as! NSDictionary
        //let t = weatherData.value(forKeyPath: "temp") as? String
        //let h = weatherData.value(forKeyPath: "humidity") as? String
        //print(t)
        //print(h)
        if weatherData.value(forKeyPath: "temp") != nil {
        let t = weatherData.value(forKeyPath: "temp") as? Double
        let h = weatherData.value(forKeyPath: "humidity") as? Double
        temp = NSString(format: "%.1f", t!) as String
        humid = NSString(format: "%.1f", h!) as String
        }
    }
    
    @IBAction func updatePressed(_ sender: Any) {
        let t = weatherData.value(forKeyPath: "temp") as? Double
        let h = weatherData.value(forKeyPath: "humidity") as? Double
        temp = NSString(format: "%.1f", t!) as String
        humid = NSString(format: "%.1f", h!) as String
        
        print(temp)
        print(humid)
        
        self.tempLabel.text = temp
        self.humidLabel.text = humid
        //print(weatherData)
    }
    
    
    
    
}
