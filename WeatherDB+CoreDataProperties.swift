//
//  WeatherDB+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Software Merchant on 1/17/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import Foundation
import CoreData


extension WeatherDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDB> {
        return NSFetchRequest<WeatherDB>(entityName: "WeatherDB");
    }

    @NSManaged public var desc: String?
    @NSManaged public var humadity: String?
    @NSManaged public var imageIcon: String?
    @NSManaged public var temp: String?

}
