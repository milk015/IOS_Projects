//
//  ViewController.swift
//  MAPAssignment2-current
//
//  Created by Jorge Bejarano on 2020-04-02.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, UISearchBarDelegate,UISearchDisplayDelegate, addCityProto {
    func addCityIsFinsihed(isDone: Bool) {
        if isDone == true{
            tableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var addCity: UIBarButtonItem!
    
    
    
    
    
    var cities: [NSManagedObject] = []
    
    var delegat = UIApplication.shared.delegate as! AppDelegate
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var updateTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
        timer in
            self.fetch()
        }
        // Do any additional setup after loading the view.
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mainCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CityData")
        do {
            cities = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetch()  {
        let fetchRequest : NSFetchRequest = CityData.fetchRequest()
        do{
            cities = try context.fetch(fetchRequest)
            tableView.reloadData()
        }
        catch{
            
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        let thisCity = cities[indexPath.row]
        cell.textLabel?.text = thisCity.value(forKeyPath: "cityName") as? String
        cell.detailTextLabel?.text = thisCity.value(forKeyPath: "country") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(cities[indexPath.row])
            delegat.saveContext()
            fetch()
            
        } else if editingStyle == .insert {
            
        }
    }
    
    //SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /*
        if (searchText == ""){
            fetch()
        }else {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CityData")
            
            let predicate = NSPredicate(format: "cityname CONTAINS [c] %@", searchText)
            
            let order = NSSortDescriptor(key: "cityName", ascending: true)
            
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = [order]
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            do{
                cities = try managedContext.fetch(fetchRequest)
                tableView.reloadData()
            }
            catch{}
        }*/
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView" {
            let dvc = segue.destination as! detailViewController
            
            if let row = tableView.indexPathForSelectedRow?.row {
                let selection = cities[row]
                dvc.detailViewDelegate = (selection.value(forKey: "cityName") as? String)!
                dvc.getData(city: dvc.detailViewDelegate)
            }
            
        }
    }
    
}

