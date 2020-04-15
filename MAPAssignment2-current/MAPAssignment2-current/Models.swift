//
//  Models.swift
//  MAPAssignment2-current
//
//  Created by Jorge Bejarano on 2020-04-07.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//
//
//Both CitySearch and Weather Api classes are here

import Foundation
import UIKit
import CoreData


protocol SearchCityDelegate {
    func SearchDidFinishWithData(data: NSArray)
}

protocol getWeatherDelegate {
    func weatherWasRecieved(data: NSDictionary)
}

class SearchCity { //used for city searching
    
    var delegate : SearchCityDelegate?
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //let manage = appDelegate.persistentContainer.viewContext
    
    func getCityData(searchString : String){
        
        let urlstr = URL(string: "http://gd.geobytes.com/AutoCompleteCity?callback=?&q=\(searchString)")
        
        DispatchQueue(label: "cityGrab", qos: .background).async {
            if let urlObj = urlstr{
                do {
                    URLSession.shared.dataTask(with: urlObj) {(data, respose, error) in
                        if (error != nil){
                            print(error?.localizedDescription ?? "Error Ocurred")
                        }else{
                            if data != nil {
                                let convertToString = String(data: data!, encoding: String.Encoding.utf8)
                                let str1 = convertToString?.dropFirst(2)
                                let str2 = str1?.dropLast(2)
                                if let data = str2?.data(using: String.Encoding.utf8) {
                                    let allData = try! JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                                    DispatchQueue.main.async {
                                        self.delegate?.SearchDidFinishWithData(data: allData as NSArray)
                                    }
                                }
                            }
                        }
                        
                    }.resume()
                }
            }
        }
    }
    
    //saving list & data
    func saveSelected(selectedString: String){
        print(selectedString)
        var city = ""
        var code = ""
        var country = ""
        var garbage = ""
        var citySet = false
        var codeSet = false
        //var countrySet = false
        for char in selectedString {
            if citySet == false {
                if char != ","{
                    city.append(char)
                    
                }else{
                    citySet = true
                    garbage.append(char)
                }
            }
            else if codeSet == false && citySet == true{
                if char != "," {
                    code.append(char)
                }else{
                    codeSet = true
                    garbage.append(char)
                }
            }
            else{
                country.append(char)
            }
        }
        print(city)
        print(garbage)
        print(code)
        print(country)
        
        let entity = NSEntityDescription.entity(forEntityName: "CityData", in: appDelegate.persistentContainer.viewContext)!
        let citySave = NSManagedObject(entity: entity, insertInto: appDelegate.persistentContainer.viewContext)
        citySave.setValue(city, forKey: "cityName")
        citySave.setValue(code, forKey: "uID")
        citySave.setValue(country, forKey: "country")
        
        do{
        appDelegate.saveContext()
        }/*catch let error as NSError{
            print("save Error")
        }*/
    }
    
}//End of citySearch class



//api.openweathermap.org/data/2.5/weather?q={city name},{state},{country code}&appid={your api key}
class weatherApi{
    let unit = "metric"
    let key = "1d7e47ce4467b3ad62f9a6cdab6cf7e8"
    
    var delegate: getWeatherDelegate?
    
    func getWeatherData(city: String){
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(key)&units=\(unit)"
        
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) {data, response, error in
                if let data = data {
                    let strData = String(data: data, encoding: .utf8)
                    print(strData!, "strData")
                    do{
                        let jsonData = Data(strData!.utf8)
                        
                        let array = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary
                        //print(array,"this is the array")
                        let organized = array?.value(forKey: "main") as? NSDictionary
                        self.delegate?.weatherWasRecieved(data: organized!)
                        print(organized,"end print")
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }//end url
    }//end func
}//end of weatherApi class
