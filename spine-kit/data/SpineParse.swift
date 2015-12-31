//
//  SpineParse.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation
import UIKit

class SpineParse {

    func parse(name: String, data: String?) -> SpineModel?{
        var result: SpineModel?
        
        do {
            if let data = data  {
                
                let dataObject = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                if let dataObject = dataObject {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(dataObject, options: [])
                    if let json = json as? JSON {
                        result = SpineModel.decode(json)
                        result?.name = name
                    }
                }
            }
            
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        return result
    }
    

}
