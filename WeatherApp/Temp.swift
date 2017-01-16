//
//	Temp.swift
//
//	Create by Software Merchant on 10/1/2017
//	Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation

struct Temp{

	var day : Float!
	var eve : Float!
	var max : Float!
	var min : Float!
	var morn : Float!
	var night : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		day = dictionary["day"] as? Float
		eve = dictionary["eve"] as? Float
		max = dictionary["max"] as? Float
		min = dictionary["min"] as? Float
		morn = dictionary["morn"] as? Float
		night = dictionary["night"] as? Float
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if day != nil{
			dictionary["day"] = day
		}
		if eve != nil{
			dictionary["eve"] = eve
		}
		if max != nil{
			dictionary["max"] = max
		}
		if min != nil{
			dictionary["min"] = min
		}
		if morn != nil{
			dictionary["morn"] = morn
		}
		if night != nil{
			dictionary["night"] = night
		}
		return dictionary
	}

}
