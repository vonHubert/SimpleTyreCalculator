//
//  Model.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 03.12.2022.
//

import Foundation

struct WheelSet {
    // all variables are Float for ease of calculations
    var rimSize: Float // diameter, set in inches, 1 inch increment.
    var rimWidth: Float // diameter, set in inches, 0.5 inch increment, min 5, max 12
    var rimOffset: Float // set in mm, min -65, max 65
    
    var tyreWidth: Float // set in mm, 10mm increment, min 135, max 375
    var tyreHeight: Float // set in % of tyreWidth, 5% increment, min 20, max 100
    
    var totalWheelDiameter: Float {
        (rimSize * 25.4) + 2 * (tyreWidth * tyreHeight / 100)
    }
    
    var totalWheelCircle: Float {
        totalWheelDiameter * Float(Double.pi)
    }
    
}

struct PickerData {
    static func getRimSizesData() -> [String] {
        ["13", "14", "15", "16", "17", "18", "19", "20"]
    }
    
    static func getRimWidthsData() -> [String] {
        var rimWidths = [String]()
        var width = 5.0
        while width <= 12 {
            width += 0.5
            rimWidths.append(String(width))
        }
        return rimWidths
    }
    
    static func getRimOffsetsData() -> [String] {
        var rimOffsets = [String]()
        var offset = -20
        while offset <= 50 {
            offset += 2
            rimOffsets.append(String(offset))
        }
        return rimOffsets
    }
    
    static func getTyreWidthsData() -> [String] {
        var tyreWidths = [String]()
        var width = 135
        while width <= 375 {
            width += 10
            tyreWidths.append(String(width))
        }
        return tyreWidths
    }
    
    static func getTyreHeigthsData() -> [String] {
        var tyreHeights = [String]()
        var height = 20
        while height <= 100 {
            height += 5
            tyreHeights.append(String(height))
        }
        return tyreHeights
    }
}

