//
//  ServiceManager.swift
//  WeatherApp
//
//  Created by Software Merchant on 1/10/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import Foundation

class ServiceManager: NSObject {
    
    func weatherDataOfCity(city: String, completionHandler:@escaping (Bool, RootClass, String) -> ()) {
        
        var strUrl:String = "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&mode=json&units=metric&cnt=16&appid=27415d274850f186fa3de020d5fbbc28"
        strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: strUrl) else {
            print("Error to create URL")
            return
        }
        
        ServiceFactory.dictionaryResponse(url: url, complitionHandler: {(isSuccess, dictData, message) -> () in
            
            if !isSuccess {
                print(message)
                completionHandler(false, RootClass(), message)
            }
            else {
                
                let result = RootClass(fromDictionary: (dictData as? NSDictionary)!)
                completionHandler(true, result, "Success")
            }
        })
    }
}
