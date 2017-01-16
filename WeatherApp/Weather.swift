//
//	Weather.swift
//
//	Create by Software Merchant on 10/1/2017
//	Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation

struct Weather{

	var descriptionField : String!
	var icon : String!
	var id : Int!
	var main : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		descriptionField = dictionary["description"] as? String
		icon = dictionary["icon"] as? String
		id = dictionary["id"] as? Int
		main = dictionary["main"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if icon != nil{
			dictionary["icon"] = icon
		}
		if id != nil{
			dictionary["id"] = id
		}
		if main != nil{
			dictionary["main"] = main
		}
		return dictionary
	}

}
