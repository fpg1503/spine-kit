//
//  MathUtils.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/21/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import CoreGraphics

class MathUtils {
    
    func shortestAngleBetweenInRadians(origin: Double, to dest: Double) -> (origin: Double, dest: Double) {
        return self.shortestAngleBetween(origin, to: dest, halfCircle: M_PI)
    }
    
    func shortestAngleBetweenInDegrees(origin: Double, to dest: Double, halfCircle: Double) -> (origin: Double, dest: Double) {
        return self.shortestAngleBetween(origin, to: dest, halfCircle: 180)
    }

    private func shortestAngleBetween(origin: Double, to dest: Double, halfCircle: Double) -> (origin: Double, dest: Double) {
        
        var origin = self.positiveAngle(origin, halfCicle: halfCircle)
        var dest = self.positiveAngle(dest, halfCicle: halfCircle)
        
        if origin > dest {
            if origin - dest > halfCircle {
                origin = origin - (halfCircle * 2)
            }
        } else if dest - origin > halfCircle {
            dest = dest - (halfCircle * 2)
        }
        return (origin, dest)
    }

    private func positiveAngle(angle: Double, halfCicle: Double) -> Double {
        var result = angle
        while (result < 0) {
            result += (halfCicle * 2)
        }
        return result
    }
}

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
    
    var radiansToDegrees: CGFloat {
        return CGFloat(self) * 180 / CGFloat(M_PI)
    }
}

extension Double {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
    
    var radiansToDegrees: CGFloat {
        return CGFloat(self) * 180 / CGFloat(M_PI)
    }
}

extension Float {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
    
    var radiansToDegrees: CGFloat {
        return CGFloat(self) * 180 / CGFloat(M_PI)
    }
}

extension CGFloat {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
    
    var radiansToDegrees: CGFloat {
        return CGFloat(self) * 180 / CGFloat(M_PI)
    }
}
