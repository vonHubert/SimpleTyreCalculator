//
//  ResultsViewController.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 03.12.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet var resultsLabel: UILabel!
    
    var wheelBefore: WheelSet = WheelSet(
        rimSize: 13,
        rimWidth: 5,
        rimOffset: -20,
        tyreWidth: 135,
        tyreHeight: 20
    )
    
    var wheelAfter: WheelSet = WheelSet(
        rimSize: 13,
        rimWidth: 5,
        rimOffset: -20,
        tyreWidth: 135,
        tyreHeight: 20
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showResults()
    }
    
    
     func showResults() {
        resultsLabel.text = """
   \(WheelSet.compareSpidometer(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))
   \(WheelSet.checkTyreDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))
   \(WheelSet.checkRimDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))
   \(WheelSet.checkTireWidthFitment(wheelSetInput: wheelAfter))
   \(WheelSet.checkInnerWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))
   \(WheelSet.checkOuterWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))
"""
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}



//    let sizeMultiplier:CGFloat = 50

//    @IBAction func offsetSlider(_ sender: UISlider) {
//        offsetLabel.text = "\(tyreView.frame.size.height)"
//        offsetConstraint.constant = CGFloat(offsetSlider.value) * sizeMultiplier
//
//    }
//
//    @IBAction func widthSlider(_ sender: UISlider) {
//        tyreView.frame.size.height = CGFloat(offsetSlider.value) * sizeMultiplier
//    }
//
