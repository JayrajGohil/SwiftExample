//
//	Coord.swift
//
//	Create by Software Merchant on 10/1/2017
//	Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation

struct Coord{

	var lat : Float!
	var lon : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		lat = dictionary["lat"] as? Float
		lon = dictionary["lon"] as? Float
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if lat != nil{
			dictionary["lat"] = lat
		}
		if lon != nil{
			dictionary["lon"] = lon
		}
		return dictionary
	}

}
