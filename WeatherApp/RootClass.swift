//
//	RootClass.swift
//
//	Create by Software Merchant on 10/1/2017
//	Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation

struct RootClass{

	var city : City!
	var cnt : Int!
	var cod : String!
	var list : [List]!
	var message : Float!


    init(){
        city = City(fromDictionary: NSDictionary())
        cnt = 0
        cod = ""
        list = [List]()
        message = 0.0
    }
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let cityData = dictionary["city"] as? NSDictionary{
				city = City(fromDictionary: cityData)
			}
		cnt = dictionary["cnt"] as? Int
		cod = dictionary["cod"] as? String
		list = [List]()
		if let listArray = dictionary["list"] as? [NSDictionary]{
			for dic in listArray{
				let value = List(fromDictionary: dic)
				list.append(value)
			}
		}
		message = dictionary["message"] as? Float
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if city != nil{
			dictionary["city"] = city.toDictionary()
		}
		if cnt != nil{
			dictionary["cnt"] = cnt
		}
		if cod != nil{
			dictionary["cod"] = cod
		}
		if list != nil{
			var dictionaryElements = [NSDictionary]()
			for listElement in list {
				dictionaryElements.append(listElement.toDictionary())
			}
			dictionary["list"] = dictionaryElements
		}
		if message != nil{
			dictionary["message"] = message
		}
		return dictionary
	}

}
