//
//  Model.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 03.12.2022.
//

import Foundation

// MARK: Wheelset Model

struct WheelSet {
    
    // MARK: Wheelset Properties
    
    // rim specks
    var rimSize: Float = 13 // set in inches, 1 inch increment.
    var rimWidth: Float = 6 // set in inches, 0.5 inch increment, min 5, max 12
    var rimOffset: Float = -20 // set in mm, min -20, max 50
    
    // tyre specks
    var tyreWidth: Float = 165 // set in mm, 10mm increment, min 135, max 375
    var tyreHeight: Float = 20 // set in % of tyreWidth, 5% increment, min 20, max 100
    
    // getters
    var rimSizeMM: Float { rimSize * 25.4 }
    var rimWidthMM: Float { rimWidth * 25.4 }
    var tyreHeightMM: Float { tyreWidth * tyreHeight / 100 }
    var totalWheelDiameter: Float { rimSizeMM + 2 * tyreHeightMM }
    var totalWheelCircle: Float { totalWheelDiameter * Float(Double.pi) }
}

// MARK: Messages generation

extension WheelSet {
    
    static func compareSpidometer(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> (Message: String, Warning: Bool) {
        let referenceSpeed: Float = 60
        var speedometerDelta: Float { wheelAfterInput.totalWheelCircle / wheelBeforeInput.totalWheelCircle * 100 - 100 }
        var actualSpeed: Float { referenceSpeed * ( 1 + speedometerDelta / 100 ) }
        
        if speedometerDelta > 0 {
            return ( "Whith a new wheel set a speedometer will show speed \(String(format: "%.1f", speedometerDelta))% lower than actual, if it reads \(referenceSpeed) km/h, actual speed will be \(String(format: "%.1f", actualSpeed)) km/h", false)
        } else {
            return ("Whith a new wheel set a speedometer will show speed \(String(format: "%.1f", speedometerDelta))% higher than actual, if it reads \(referenceSpeed) km/h, actual speed will be \(String(format: "%.1f", actualSpeed)) km/h", false)
        }
    }
    
    static func checkTyreDiameterFitment(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> (Message: String, Warning: Bool) {
        
        let tyreDiameterChange = wheelAfterInput.totalWheelDiameter - wheelBeforeInput.totalWheelDiameter
        
        if tyreDiameterChange > 15 {
            return ("New tyre diameter of \(String(format: "%.0f",wheelAfterInput.totalWheelDiameter))mm is \(String(format: "%.0f",tyreDiameterChange))mm higher and may cause scrubbing on wheel archs", true)
        } else {
            return ("New tyre diameter of \(String(format: "%.0f",wheelAfterInput.totalWheelDiameter))mm is not expected to cause fitment issues", false)
        }
    }
    
    static func checkRimDiameterFitment(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> (Message: String, Warning: Bool) {
        
        let rimDiameterChange = wheelAfterInput.rimSize - wheelBeforeInput.rimSize
        
        if rimDiameterChange < 0 {
            return ("New rim diameter of \(String(format: "%.0f",wheelAfterInput.rimSize)) Inches is \(String(format: "%.0f", rimDiameterChange)) Inches lower and may cause scrubbing on brake calipers", true)
        } else {
            return ("New rim diameter of \(String(format: "%.0f",wheelAfterInput.rimSize)) Inches is not expected to cause fitment issues", false)
        }
    }
    
    static func checkTyreHeight(wheelSetInput: WheelSet) -> (Message: String, Warning: Bool) {
        
        if wheelSetInput.tyreHeightMM < 80 {
            return ("New tyre height of \(String(format: "%.0f",wheelSetInput.tyreHeightMM)) mm. is low and may cause tyre, rim and suspension damage on rough roads", true)
        } else {
            return ("New tyre height of \(String(format: "%.0f",wheelSetInput.tyreHeightMM)) mm. is not expected to cause issues", false)
        }
    }
    
    
    static func checkTireWidthFitment(wheelSetInput: WheelSet) -> (Message: String, Warning: Bool) {
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
            return ("This tyre is too narrow for selected rim width", true)
        } else if wheelSetInput.tyreWidth > maximumTyreWidth {
            return ("This tyre is too wide for selected rim width", true)
        } else {
            return ("This tyre width is correct for selected rim width", false)
        }
    }
    
    
    static func checkInnerWheelFitment(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> (Message: String, Warning: Bool) {
        var innerTyreWallPositionBefore: Float { wheelBeforeInput.tyreWidth / 2 + wheelBeforeInput.rimOffset }
        var innerTyreWallPositionAfter: Float { wheelAfterInput.tyreWidth / 2 + wheelAfterInput.rimOffset }
        var innerTyreWallPositionChange: Float { innerTyreWallPositionAfter - innerTyreWallPositionBefore }
        
        switch innerTyreWallPositionChange {
        case 15...:
            return ("Inner tyre wall is \(Int(innerTyreWallPositionChange)) mm. closer to suspension components and may cause scrubbing. Conscider narrower rims and tyres or lower offset", true)
        case -5 ... 15:
            return ("New tyre and rim width and offset combination is close to initial. No problems expected.", false)
        default:
            return ("Inner tyre wall is \(Int(-innerTyreWallPositionChange)) mm. futher away from suspencion components. No problems expected.", false)
        }
    }
    
    static func checkOuterWheelFitment(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> (Message: String, Warning: Bool) {
        var outerTyreWallPositionBefore: Float { wheelBeforeInput.tyreWidth / 2 - wheelBeforeInput.rimOffset }
        var outerTyreWallPositionAfter: Float { wheelAfterInput.tyreWidth / 2 - wheelAfterInput.rimOffset }
        var outerTyreWallPositionChange: Float { outerTyreWallPositionAfter - outerTyreWallPositionBefore }
        
        switch outerTyreWallPositionChange {
        case 15...:
            return ("Outer tyre wall sticks \(Int(outerTyreWallPositionChange)) mm. futher away and may cause scrubbing on wheel archs. Conscider narrower rims and tyres or higher offset", true)
        case -5 ... 15:
            return ("New tyre and rim width and offset combination is close to initial. No problems expected.", false)
        default:
            return ("Inner tyre wall sticks \(Int(-outerTyreWallPositionChange)) mm. out less in a wheel arch. No problems expected. May look ugly though)", false)
        }
    }
    
    static func generateResults(wheelBeforeInput: WheelSet, wheelAfterInput: WheelSet) -> [ResultsMessage] {
        var results:[ResultsMessage] = []
        let wheelBefore: WheelSet = wheelBeforeInput
        let wheelAfter: WheelSet = wheelAfterInput
        
        results.append(ResultsMessage(
            title: "Spidometer:",
            message: WheelSet.compareSpidometer(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Message,
            warning: WheelSet.compareSpidometer(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Warning
        ))
        results.append(ResultsMessage(
            title: "Wheel size fitment:",
            message: WheelSet.checkTyreDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Message,
            warning: WheelSet.checkTyreDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Warning
        ))
        results.append(ResultsMessage(
            title: "Rim diameter fitment:",
            message: WheelSet.checkRimDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Message,
            warning: WheelSet.checkRimDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Warning
        ))
        results.append(ResultsMessage(
            title: "Tyre to rim fitment:",
            message: WheelSet.checkTireWidthFitment(wheelSetInput: wheelAfter).Message,
            warning: WheelSet.checkTireWidthFitment(wheelSetInput: wheelAfter).Warning
        ))
        results.append(ResultsMessage(
            title: "Tyre sidewall height:",
            message: WheelSet.checkTyreHeight(wheelSetInput: wheelAfter).Message,
            warning: WheelSet.checkTyreHeight(wheelSetInput: wheelAfter).Warning
        ))
        
        results.append(ResultsMessage(
            title: "Suspension fitment:",
            message: WheelSet.checkInnerWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Message,
            warning: WheelSet.checkInnerWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Warning
        ))
        results.append(ResultsMessage(
            title: "Fender fitment:",
            message: WheelSet.checkOuterWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Message,
            warning: WheelSet.checkOuterWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Warning
        ))
        return results
    }
    
}

// MARK: PickerView Selection Database

struct PickerData {
    static func getRimSizesData() -> [String] {
        ["13", "14", "15", "16", "17", "18", "19", "20"]
    }
    
    static func getRimWidthsData() -> [String] {
        var rimWidths = [String]()
        var width: Double = 5
        while width <= 12 {
            width += 0.5
            rimWidths.append(String(width))
        }
        return rimWidths
    }
    
    static func getRimOffsetsData() -> [String] {
        var rimOffsets = [String]()
        var offset = -22
        while offset <= 50 {
            offset += 2
            rimOffsets.append(String(offset))
        }
        return rimOffsets
    }
    
    static func getTyreWidthsData() -> [String] {
        var tyreWidths = [String]()
        var width = 145
        while width <= 345 {
            width += 10
            tyreWidths.append(String(width))
        }
        return tyreWidths
    }
    
    static func getTyreHeigthsData() -> [String] {
        var tyreHeights = [String]()
        var height = 15
        while height <= 80 {
            height += 5
            tyreHeights.append(String(height))
        }
        return tyreHeights
    }
}

// MARK: Results Message Model

struct ResultsMessage {
    let title: String
    let message: String
    let warning: Bool
}


