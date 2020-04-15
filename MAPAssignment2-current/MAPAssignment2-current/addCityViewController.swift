//
//  addCityViewController.swift
//  MAPAssignment2-current
//
//  Created by Jorge Bejarano on 2020-04-06.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//
//city search api to grab city code for weather api
//api url http://gd.geobytes.com/AutoCompleteCity?callback=?&q=
//


import UIKit
import CoreData


protocol addCityProto {
    func addCityIsFinsihed(isDone: Bool)
}

class addCityViewController : UITableViewController,UISearchBarDelegate,SearchCityDelegate{
    
    struct prepareToSave {
        var city: String = ""
        var code: String = ""
        var country: String = ""
    }
    
    
    lazy var list = NSArray()
    lazy var cityModel = SearchCity()
    
    var helpDelegate: addCityProto?
    
    var saveArray: [prepareToSave] = []
    
    //string
    var strForCity = ""
    
    //Index
    var saveIndex = 0
    //////////////////////
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityModel.delegate = self;
    }
    
    
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        cityModel.getCityData(searchString: searchText)
        tableView.reloadData()
    }
    
    func SearchDidFinishWithData(data: NSArray) {
        list = data
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addingCell", for: indexPath)
        
        let city = list[indexPath.row]
        cell.textLabel?.text = city as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        strForCity = list[indexPath.row] as! String
        /*
         var city = ""
         var code = ""
         var country = ""
         var garbage = ""
         var citySet = false
         var codeSet = false
         var countrySet = false
         for char in strForCity {
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
         */
        cityModel.saveSelected(selectedString: strForCity)
        //helpDelegate?.addCityIsFinsihed(strCityData: strForCity)
        let alertController = UIAlertController(title: "Saved", message: "Selected City Has Been Saved", preferredStyle: .alert)
        
        /*let okBtn = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed OK");
        }*/
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {(ACTION) in self.navigationController?.popToRootViewController(animated: true)}))

        self.present(alertController, animated: true, completion: nil)
        helpDelegate?.addCityIsFinsihed(isDone: true)
    }
    
    
    
    
}
