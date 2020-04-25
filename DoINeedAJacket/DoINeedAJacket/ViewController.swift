//
//  ViewController.swift
//  DoINeedAJacket
//
//  Created by Jorge Bejarano on 2020-04-15.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var actionBtn: UIButton!
    
    @IBOutlet weak var jacketLabel: UILabel!
    
    
    //location
    private var locationManager:CLLocationManager?
    //Needed vars for location
    var lat: String?
    var lng: String?
    
    //model
    var weatherLib = Weather()
    var temp = 100.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //init get location
        getUserLocation()
        //init get weather
        if lat != nil {
            jacketGetter(lat: lat!, long: lng!)
        }
    }
    
    //grabbing Permission/location
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
    //passing location to parameters
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lat = "\(location.coordinate.latitude)"
            lng = "\(location.coordinate.longitude)"
            print(lat)
            print(lng)
        }
    }
    
    //Get Weather fun
    
    func jacketGetter(lat: String, long: String){
        weatherLib.getWeather(lat: lat, long: long) { (allWeather) in
            let t = allWeather.value(forKeyPath: "main.temp") as! Double
            
            self.temp = t
            
        }
        //regular use
        if temp != 100.0 {
            if temp < 0.0{
                print("freezing")
                self.jacketLabel.text = "Get your Winter Coat!"
            }
            else if temp < 10.0{
                print("colder")
                self.jacketLabel.text = "Better put on a jacket"
            }
            else if temp < 15.0{
                print("sweater weather")
                self.jacketLabel.text = "Sweater Weather!"
            }else{
                print ("nope")
                self.jacketLabel.text = "T-Shirt Time"
            }
        }
        
        // init loop
        while temp == 100.0{
            if temp == 100.0{
                //init
            }
            else if temp < 0.0{
                print("freezing")
                self.jacketLabel.text = "Get your Winter Coat!"
            }
            else if temp < 10.0{
                print("colder")
                self.jacketLabel.text = "Better put on a jacket"
            }
            else if temp < 15.0{
                print("sweater weather")
                self.jacketLabel.text = "Sweater Weather!"
            }else{
                print ("nope")
                self.jacketLabel.text = "T-Shirt Time"
            }
        }
    }
    
    //If pressed gets weather with location
    @IBAction func btnIsPressed(_ sender: UIButton) {
        print(temp)
        jacketGetter(lat: lat!, long: lng!)
        
    }
    
    
}

