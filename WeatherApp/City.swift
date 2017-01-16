//
//	City.swift
//
//	Create by Software Merchant on 10/1/2017
//	Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation

struct City{

	var coord : Coord!
	var country : String!
	var id : Int!
	var name : String!
	var population : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let coordData = dictionary["coord"] as? NSDictionary{
				coord = Coord(fromDictionary: coordData)
			}
		country = dictionary["country"] as? String
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		population = dictionary["population"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if coord != nil{
			dictionary["coord"] = coord.toDictionary()
		}
		if country != nil{
			dictionary["country"] = country
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if population != nil{
			dictionary["population"] = population
		}
		return dictionary
	}

}
