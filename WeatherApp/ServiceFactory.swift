//
//  ServiceFactory.swift
//  WeatherApp
//
//  Created by Software Merchant on 1/10/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import Foundation
import UIKit

class ServiceFactory: NSObject {
    
    class func dictionaryResponse(url: URL, complitionHandler:@escaping (Bool, [String: AnyObject], String)->()) {
        
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: urlRequest){data,response,error in
            
            guard error == nil else {
                print("Error occurs: \(error)")
                complitionHandler(false, [String: AnyObject](), "Error occurs \(error?.localizedDescription)")
                return
            }
            
            guard let responseData = data else {
                print("Error in getting Response data")
                complitionHandler(false, [String: AnyObject](), "Error in getting Response data")
                return
            }
            
            do{
                guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    complitionHandler(false, [String: AnyObject](), "Error to convert Data to JSON")
                    return
                }
                
                complitionHandler(true, jsonData, "")
                
            }
            catch{
                print("Error to convert Data to JSON")
                complitionHandler(false, [String: AnyObject](), "Throw catch while convert Data to JSON")
            }
        }
        
        task.resume()
    }
    
    
    class func downloadImage(url: URL, callBack:@escaping (UIImage?) -> ()) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(responseData, responseURL, error) -> Void in
            
            var image:UIImage = UIImage()
            if let data = responseData {
                image = UIImage(data: data)!
            }
            
            DispatchQueue.main.async {
                callBack(image)
            }
        })
        task.resume()
    }
    
    
}
