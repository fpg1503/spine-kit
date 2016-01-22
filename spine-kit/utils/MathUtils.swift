//
//  MathUtils.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/21/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import CoreGraphics

class MathUtils {
    
    func shortestAngleBetween(point: (origin: Double, dest: Double)) -> (origin: Double, dest: Double) {
        let pi = M_PI

        var origin = self.positiveAngle(point.origin)
        var dest = self.positiveAngle(point.dest)
        
        if origin > dest {
            if origin - dest > M_PI {
                origin = origin - (pi * 2)
            }
        } else if dest - origin > pi {
            dest = dest - (pi * 2)
        }
        return (origin, dest)
    }
    
    private func positiveAngle(angle: Double) -> Double {
        return angle < 0 ?  angle + (M_PI * 2) : angle;
    }
}

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

extension Double {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

extension Float {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}
