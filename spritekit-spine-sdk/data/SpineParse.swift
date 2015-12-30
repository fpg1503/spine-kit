//
//  SpineParse.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation
import UIKit

class SpineParse {

    func parse(name: String, data: String) -> Skeleton?{
        var result: Skeleton?
        
        do {
            if !data.isEmpty {
                
                let json = try NSJSONSerialization.JSONObjectWithData((data as NSString).dataUsingEncoding(NSUTF8StringEncoding)!, options: .AllowFragments)
                
            }
        } catch {
            print("Error serializing JSON: \(error)")
        }
        
        return result
    }
    

}