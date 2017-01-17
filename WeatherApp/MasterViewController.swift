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
    var arrayWeather = [WeatherDB]()
    
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
                
                DispatchQueue.main.async {
                    self.storeWeatherData()
                    self.fetchAllWeatherFromDatabase()
                    self.tableView.reloadData()
                }
                
            }
        })
    }

    
    func storeWeatherData () {
        
        for listObj in self.result.list as [List] {
         
            let weather : WeatherDB = WeatherDB(context: DatabaseManager.getContext())

            if listObj.weather[0].descriptionField != nil {
                weather.desc = listObj.weather[0].descriptionField!
            }
            else {
                weather.desc = "No Data"
            }
            
            if listObj.temp.day != nil {
                weather.temp = "\(listObj.temp.day!)"
            }
            else {
                weather.temp = "No Data"
            }
            
            if listObj.humidity != nil {
                weather.humadity = "\(listObj.humidity!)"
            }
            else {
                weather.humadity = "No Data"
            }
            
            if listObj.weather[0].icon != nil {
                weather.imageIcon = "http://openweathermap.org/img/w/\(listObj.weather[0].icon!).png"
            }
            else {
                weather.imageIcon = ""
            }
            
            DatabaseManager.saveContext()
        }
    }

    func fetchAllWeatherFromDatabase()
    {
        // Create fetch request for WeatherDB Entity
        let fetchRequest  : NSFetchRequest <WeatherDB> = WeatherDB.fetchRequest()
        
        do{
            // Execute fetch request
            let searchResults = try DatabaseManager.getContext().fetch(fetchRequest)
            
            // Update WeatherDB array with new result
            self.arrayWeather = searchResults
        }
        catch{
            // Handle Error
            print("Error:\(error)")
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
        let listObject: WeatherDB = self.arrayWeather[indexPath.row]
        if  listObject.temp != nil {
            cell.lblTemp.text = "Temp: \(listObject.temp!)"
        }
        if listObject.humadity != nil {
            cell.lblHumadity.text = "Humidity: \(listObject.humadity!)"
        }
        if listObject.desc != nil {
            cell.lblDescription.text = "Description: \(listObject.desc!)"
        }
        if listObject.imageIcon != nil {
            let imageURL = listObject.imageIcon
            if let image = cachedImages[imageURL!] {
                cell.btnIcon.setImage(image, for: .normal)
            }
            else {
                let strUrl = listObject.imageIcon?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let url:URL = URL(string: strUrl!)!
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
