//
//  FileController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation


struct FileHelper {

    static func loadTextFile(fileName: String, type: String) -> String? {
        
        var result: String? = nil
        
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: type) {
            do {
                result = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
            } catch {
                print("Fail to load text file: \(error)")
            }
        }
        return result
    }
}