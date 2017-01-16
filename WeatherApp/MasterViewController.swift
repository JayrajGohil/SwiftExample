//
//  MasterViewController.swift
//  WeatherApp
//
//  Created by Software Merchant on 1/11/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, WeatherTableCellDelegate {

    var result = RootClass()
    var cachedImages = [String: UIImage]()
    var arrayWeather = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let svm = ServiceManager()
        svm.weatherDataOfCity(city: "Philadelphia", completionHandler: {(isSuccess, rootClass, message) -> ()in
            
            if !isSuccess {
                self.alertWithMessage(message: message)
            }
            else {
                self.result = rootClass
                self.storeWeatherData()
                self.fetchAllWeatherFromDatabase()
            }
        })
    }

    
    func storeWeatherData () {
        let context =  AppDelegate.getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "WeatherDB", in: context)
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        for objList in self.result.list {
            
            //set the entity values
            transc.setValue("\(objList.humidity!)", forKey: "humadity")
            transc.setValue("\(objList.temp.day!)", forKey: "temp")
            transc.setValue("\(objList.weather[0].icon!)", forKey: "imageIcon")
            transc.setValue("\(objList.weather[0].descriptionField!)", forKey: "desc")
            
            //save the object
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        }
    }
    
    func fetchAllWeatherFromDatabase()
    {
        
        
        let context =  AppDelegate.getContext()
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "WeatherDB", in: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try context.fetch(fetchRequest)
            
            if (result.count > 0) {
                let person = result[0] as! NSManagedObject
                
                print("1 - \(person)")
                
                if let first = person.value(forKey: "temp"), let last = person.value(forKey: "humadity") {
                    print("\(first) \(last)")
                }
                
                print("2 - \(person)")
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    func alertWithMessage(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell
        cell.delegate=self
        cell.tag = indexPath.row
        
        // Configure the cell...
        let listObject = result.list[indexPath.row]
        if listObject.temp.day != nil {
            cell.lblTemp.text = "Temp: \(listObject.temp.day!)"
        }
        
        if listObject.humidity != nil {
            cell.lblHumadity.text = "Humidity: \(listObject.humidity!)"
        }
        
        if listObject.weather[0].descriptionField != nil {
            cell.lblDescription.text = "Description: \(listObject.weather[0].descriptionField!)"
        }
        
        if listObject.weather[0].icon != nil {
            let imageURL = listObject.weather[0].icon
            if let image = cachedImages[imageURL!] {
                cell.btnIcon.setImage(image, for: .normal)
            }
            else {
                let strUrl = "http://openweathermap.org/img/w/\(listObject.weather[0].icon!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let url:URL = URL(string: strUrl)!
                ServiceFactory.downloadImage(url: url, callBack: { (responseImage) in
                    if let image = responseImage {
                        let img = image.rounded
                        cell.btnIcon.setImage(img, for: .normal)
                        cell.btnIcon.setTitle("", for: .normal)
                    }
                })
                
            }
        }
        
        return cell
    }
    
    func weatherSelected(at: Int) {
        print("Item Selected: \(at)")
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
