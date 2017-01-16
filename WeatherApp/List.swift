//
//	List.swift
//
//	Create by Software Merchant on 10/1/2017
//	Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation

struct List{

	var clouds : Int!
	var deg : Int!
	var dt : Int!
	var humidity : Int!
	var pressure : Float!
	var rain : Float!
	var snow : Float!
	var speed : Float!
	var temp : Temp!
	var weather : [Weather]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		clouds = dictionary["clouds"] as? Int
		deg = dictionary["deg"] as? Int
		dt = dictionary["dt"] as? Int
		humidity = dictionary["humidity"] as? Int
		pressure = dictionary["pressure"] as? Float
		rain = dictionary["rain"] as? Float
		snow = dictionary["snow"] as? Float
		speed = dictionary["speed"] as? Float
		if let tempData = dictionary["temp"] as? NSDictionary{
				temp = Temp(fromDictionary: tempData)
			}
		weather = [Weather]()
		if let weatherArray = dictionary["weather"] as? [NSDictionary]{
			for dic in weatherArray{
				let value = Weather(fromDictionary: dic)
				weather.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if clouds != nil{
			dictionary["clouds"] = clouds
		}
		if deg != nil{
			dictionary["deg"] = deg
		}
		if dt != nil{
			dictionary["dt"] = dt
		}
		if humidity != nil{
			dictionary["humidity"] = humidity
		}
		if pressure != nil{
			dictionary["pressure"] = pressure
		}
		if rain != nil{
			dictionary["rain"] = rain
		}
		if snow != nil{
			dictionary["snow"] = snow
		}
		if speed != nil{
			dictionary["speed"] = speed
		}
		if temp != nil{
			dictionary["temp"] = temp.toDictionary()
		}
		if weather != nil{
			var dictionaryElements = [NSDictionary]()
			for weatherElement in weather {
				dictionaryElements.append(weatherElement.toDictionary())
			}
			dictionary["weather"] = dictionaryElements
		}
		return dictionary
	}

}
