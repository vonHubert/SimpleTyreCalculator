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
    
    static func compareSpidometer(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> String {
        var speedometerDelta: Float {
            wheelAfterInput.totalWheelCircle / wheelBeforeInput.totalWheelCircle * 100 - 100
        }
        let referenceSpeed: Float = 60
        var actualSpeed: Float {
            referenceSpeed * ( 1 + speedometerDelta / 100 )
        }
        var spidometerMessage: String
        
        if speedometerDelta > 0 {
            spidometerMessage = "Whith a new wheel set a speedometer will show speed \(String(format: "%.1f", speedometerDelta))% lower than actual, if it reads \(referenceSpeed) km/h, actual speed will be \(String(format: "%.1f", actualSpeed)) km/h"
        } else {
            spidometerMessage = "Whith a new wheel set a speedometer will show speed \(String(format: "%.1f", speedometerDelta))% higher than actual, if it reads \(referenceSpeed) km/h, actual speed will be \(String(format: "%.1f", actualSpeed)) km/h"
        }
        return spidometerMessage
    }
    
   static func checkTyreDiameterFitment(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> String {
       
       let tyreDiameterChange = wheelAfterInput.totalWheelDiameter - wheelBeforeInput.totalWheelDiameter
        var tyreDiameterMessage = ""
        
        if tyreDiameterChange > 15 {
            tyreDiameterMessage = "New tyre diameter of \(String(format: "%.0f",wheelAfterInput.totalWheelDiameter))mm is \(String(format: "%.0f",tyreDiameterChange))mm higher and may cause scrubbing on wheel archs"
        } else {
            tyreDiameterMessage = "New tyre diameter of \(String(format: "%.0f",wheelAfterInput.totalWheelDiameter))mm is not expected to cause fitment issues"
        }
        return tyreDiameterMessage
    }

   static func checkRimDiameterFitment(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> String {
       
       let rimDiameterChange = wheelAfterInput.rimSize - wheelBeforeInput.rimSize
        var rimDiameterMessage = ""
        
        if rimDiameterChange < 1 {
            rimDiameterMessage = "New rim diameter of \(String(format: "%.0f",wheelAfterInput.rimSize)) Inches is \(String(format: "%.0f", -rimDiameterChange)) Inches lower and may cause scrubbing on brake calipers"
        } else {
            rimDiameterMessage = "New rim diameter of \(String(format: "%.0f",wheelAfterInput.rimSize)) Inches is not expected to cause fitment issues"
        }
        return rimDiameterMessage
    }

    
    static func checkTireWidthFitment(wheelSetInput: WheelSet) -> String {
        var idealTyreWidthCorrection: Float {
            switch wheelSetInput.rimWidth {
            case 10.5...12 : return 10.0
            case 8.5..<10.5: return 20.0
            case 6.5..<8.5: return 30.0
            default: return 40.0
            }
        }
        let idealTyreWidth: Float = round(wheelSetInput.rimWidth * 2.54 ) * 10 + idealTyreWidthCorrection
        
        var minimumTyreWidth: Float { idealTyreWidth - 15 }
        var maximumTyreWidth: Float { idealTyreWidth + 15 }
        
        if wheelSetInput.tyreWidth < minimumTyreWidth {
            return "This tyre is too narrow for selected rim width"
        } else if wheelSetInput.tyreWidth > maximumTyreWidth {
            return "This tyre is too wide for selected rim width"
        } else {
            return "This tyre width is correct for selected rim width"
        }
    }
    
    //checkTireFitment(wheelSetInput: wheelAfter)
    
    static func checkInnerWheelFitment(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> String {
        var innerTyreWallPositionBefore: Float {
            wheelBeforeInput.tyreWidth / 2 + wheelBeforeInput.rimOffset
        }
        var innerTyreWallPositionAfter: Float {
            wheelAfterInput.tyreWidth / 2 + wheelAfterInput.rimOffset
        }
        var innerTyreWallPositionChange: Float {
            innerTyreWallPositionAfter - innerTyreWallPositionBefore
        }
        
        switch innerTyreWallPositionChange {
        case 15...:
            return "Inner tyre wall is \(Int(innerTyreWallPositionChange)) mm. closer to suspension components and may cause scrubbing. Conscider narrower rims and tyres or lower offset"
        case -5 ... 15:
            return "New tyre and rim width and offset combination is close to initial. No problems expected."
        default:
            return "Inner tyre wall is \(Int(-innerTyreWallPositionChange)) mm. futher away from suspencion components. No problems expected."
        }
    }
    
    static func checkOuterWheelFitment(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> String {
        var outerTyreWallPositionBefore: Float {
            wheelBeforeInput.tyreWidth / 2 - wheelBeforeInput.rimOffset
        }
        var outerTyreWallPositionAfter: Float {
            wheelAfterInput.tyreWidth / 2 - wheelAfterInput.rimOffset
        }
        var outerTyreWallPositionChange: Float {
            outerTyreWallPositionAfter - outerTyreWallPositionBefore
        }
        
        switch outerTyreWallPositionChange {
        case 15...:
            return "Outer tyre wall sticks \(Int(outerTyreWallPositionChange)) mm. futher away and may cause scrubbing on wheel archs. Conscider narrower rims and tyres or higher offset"
        case -5 ... 15:
            return "New tyre and rim width and offset combination is close to initial. No problems expected."
        default:
            return "Inner tyre wall sticks \(Int(-outerTyreWallPositionChange)) mm. out less in a wheel arch. No problems expected. May look ugly though)"
        }
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

struct ResultsMessage {
    var title: String
    var message: String
}
