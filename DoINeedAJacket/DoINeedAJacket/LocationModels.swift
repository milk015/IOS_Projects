//
//  LocationModels.swift
//  DoINeedAJacket
//
//  Created by Jorge Bejarano on 2020-04-15.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//
//Tools for location data recieved
import Foundation

//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
class Weather {
    let apiKey = "1d7e47ce4467b3ad62f9a6cdab6cf7e8"
    let units = "metric"
    let urlObj = URLSession.init(configuration: .default)
    
    //api func
    func getWeather(lat: String,long: String, completion: @escaping (NSDictionary) -> ()) {
        let urlStr = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(apiKey)&units=\(units)")
        
        if let url = urlStr {
            urlObj.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        do {
                            let allWeather = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                            if let allWeather = allWeather {
                                if (allWeather.object(forKey: "main") != nil) {
                                    completion(allWeather)
                                }
                            }
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                else {
                    print(error?.localizedDescription ?? "error")
                }
            }.resume()
        }
    }
    
    
}
