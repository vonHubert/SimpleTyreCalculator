//
//  ResultsViewController.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 03.12.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet var resultsTableView: UITableView!
    @IBOutlet var suspensionImage: UIImageView!
    @IBOutlet var switchBeforeAfter: UISwitch!
    
    // hub image
    @IBOutlet var hubImageHeight: NSLayoutConstraint!
    
    // upper rim part
    @IBOutlet var rimUpperPartOffset: NSLayoutConstraint!
    @IBOutlet var rimUpperPart: UIView!
    @IBOutlet var rimUpperPartVerticalPos: NSLayoutConstraint!
    @IBOutlet var rimUpperPartWidth: NSLayoutConstraint!
    @IBOutlet var rimUpperFiller: UIView!
    @IBOutlet var rimUpperFillerWhiteInside: UIView!
    
    
    // lower rim part
    @IBOutlet var rimLowerPartOffset: NSLayoutConstraint!
    @IBOutlet var rimLowerPart: UIView!
    @IBOutlet var rimLowerPartVerticalPos: NSLayoutConstraint!
    @IBOutlet var rimLowerPartWidth: NSLayoutConstraint!
    @IBOutlet var rimLowerFiller: UIView!
    @IBOutlet var rimLowerFillerWhiteInside: UIView!
    
    
    // tyre upper part
    @IBOutlet var tyreUpperPart: UIView!
    @IBOutlet var tyreUpperPartHeight: NSLayoutConstraint!
    @IBOutlet var tyreUpperPartWidth: NSLayoutConstraint!
    
    // tyre lower part
    @IBOutlet var tyreLowerPart: UIView!
    @IBOutlet var tyreLowerPartHeight: NSLayoutConstraint!
    @IBOutlet var tyreLowerPartWidth: NSLayoutConstraint!
    
    // MARK: IB Variables
    
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
    
    var results:[ResultsMessage] = []
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.dataSource = self
        generateResults()
        setVisual()
        print(results)
    }
    
    // MARK: Functions
    
    func setVisual() {
        let scaleCoefficient: Float = Float(suspensionImage.frame.width) / 390.0 / 3.0
        let selectedWheel = switchBeforeAfter.isOn ? wheelAfter : wheelBefore
        
        
        // set HubSize
        hubImageHeight.constant = CGFloat(selectedWheel.rimSizeMM  * scaleCoefficient)
        
        // set rimSize (vertical constraint)
        rimUpperPartVerticalPos.constant = CGFloat(selectedWheel.rimSizeMM * scaleCoefficient * 0.5)
        rimLowerPartVerticalPos.constant = -CGFloat(selectedWheel.rimSizeMM * scaleCoefficient * 0.5)
        
        // set rimOffset (horzontal constraint)
        rimUpperPartOffset.constant = CGFloat(5.0 + selectedWheel.rimOffset  * scaleCoefficient)
        rimLowerPartOffset.constant = CGFloat(5.0 + selectedWheel.rimOffset  * scaleCoefficient)
        
        // set rimWidth
        rimUpperPartWidth.constant = CGFloat(selectedWheel.rimWidthMM * scaleCoefficient)
        rimLowerPartWidth.constant = CGFloat(selectedWheel.rimWidthMM * scaleCoefficient)
        
        
        // set tyreHeight
        tyreUpperPartHeight.constant = CGFloat(selectedWheel.tyreHeightMM * scaleCoefficient)
        tyreLowerPartHeight.constant = CGFloat(selectedWheel.tyreHeightMM * scaleCoefficient)
        
        // set tyreWidths
        tyreUpperPartWidth.constant = CGFloat(selectedWheel.tyreWidth * scaleCoefficient)
        tyreLowerPartWidth.constant = CGFloat(selectedWheel.tyreWidth * scaleCoefficient)
        
        // round corners
        rimUpperPart.layer.cornerRadius = rimUpperPart.frame.height
        rimUpperPart.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        rimUpperFiller.layer.cornerRadius = rimUpperPart.frame.height
        rimUpperFiller.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        rimUpperFillerWhiteInside.layer.cornerRadius = rimUpperPart.frame.height
        rimUpperFillerWhiteInside.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        rimLowerPart.layer.cornerRadius = rimLowerPart.frame.height
        rimLowerPart.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        rimLowerFiller.layer.cornerRadius = rimLowerPart.frame.height
        rimLowerFiller.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        rimLowerFillerWhiteInside.layer.cornerRadius = rimLowerPart.frame.height
        rimLowerFillerWhiteInside.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        tyreUpperPart.layer.cornerRadius = tyreUpperPartHeight.constant / 2.5
        tyreLowerPart.layer.cornerRadius = tyreLowerPartHeight.constant / 2.5
        
    }
    
    
    func generateResults() {
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
            title: "Suspension fitment:",
            message: WheelSet.checkInnerWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Message,
            warning: WheelSet.checkInnerWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Warning
        ))
        results.append(ResultsMessage(
            title: "Fender fitment:",
            message: WheelSet.checkOuterWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Message,
            warning: WheelSet.checkOuterWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter).Warning
        ))
        
    }
    
    // MARK: IB Actions
    
    
    @IBAction func switchBeforeAfterActivated(_ sender: UISwitch) {
        setVisual()
        print(results)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: TableView Extension


extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath)
        let result = results[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = result.title
        content.secondaryText = result.message
        content.textProperties.color = result.warning ? UIColor.red : UIColor.black
        cell.layer.cornerRadius = 5
        cell.contentConfiguration = content
        
        return cell
    }
    
}

