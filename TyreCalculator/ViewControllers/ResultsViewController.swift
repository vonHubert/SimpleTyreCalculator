//
//  ResultsViewController.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 03.12.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: IB Outlets
    
    // misc
    @IBOutlet var resultsTableView: UITableView!
    @IBOutlet var suspensionImage: UIImageView!
    @IBOutlet var switchBeforeAfter: UISwitch!
    @IBOutlet var selectorBeforeAfter: UISegmentedControl!
    
    // hub image
    @IBOutlet var hubImageHeight: NSLayoutConstraint!
    
    // upper rim part
    @IBOutlet var rimUpperPartOffset: NSLayoutConstraint!
    @IBOutlet var rimUpperPart: UIView!
    @IBOutlet var rimUpperPartVerticalPos: NSLayoutConstraint!
    @IBOutlet var rimUpperPartWidth: NSLayoutConstraint!
    @IBOutlet var rimUpperFiller: UIView!
    @IBOutlet var rimUpperFillerWhiteInside: UIView!
    @IBOutlet var rimFillerWidth: NSLayoutConstraint!
    
    // lower rim part
    @IBOutlet var rimLowerPart: UIView!
    @IBOutlet var rimLowerPartVerticalPos: NSLayoutConstraint!
    @IBOutlet var rimLowerFiller: UIView!
    @IBOutlet var rimLowerFillerWhiteInside: UIView!
    
    // tyre upper part
    @IBOutlet var tyreUpperPart: UIView!
    @IBOutlet var tyreUpperPartHeight: NSLayoutConstraint!
    @IBOutlet var tyreUpperPartWidth: NSLayoutConstraint!
    
    // tyre lower part
    @IBOutlet var tyreLowerPart: UIView!
    
    // brake rotor
    @IBOutlet var brakeRotorSize: NSLayoutConstraint!
    
    // scheme labels
    @IBOutlet var wheelSizeLabel: UILabel!
    @IBOutlet var tyreWidthLabel: UILabel!
    @IBOutlet var tyreHeightLabelMM: UILabel!
    @IBOutlet var rimWidthLabelMM: UILabel!
    
    // left side labels (rim)
    @IBOutlet var rimSizeLabel: UILabel!
    @IBOutlet var rimWidthLabelInch: UILabel!
    @IBOutlet var rimOffsetLabel: UILabel!
    
    // right side labels
    @IBOutlet var tireWidthLabel: UILabel!
    @IBOutlet var tyreHeightLabel: UILabel!
    @IBOutlet var tyreCircumference: UILabel!
    
    // MARK: Public Properties
    
    var wheelBefore: WheelSet = WheelSet()
    var wheelAfter: WheelSet = WheelSet()
    var selectedWheel: WheelSet = WheelSet()
    var results:[ResultsMessage] = []
    var scaleCoefficient: Float = 0
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scaleCoefficient = Float(suspensionImage.frame.width) / 390.0 / 3.0
        selectedWheel = wheelAfter
        resultsTableView.dataSource = self
        results = WheelSet.generateResults(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter)
        setVisualScheme()
        setLabels()
        selectorBeforeAfter.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        selectorBeforeAfter.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 26)!, NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .selected)
    }
    
    // MARK: Methods
    
   private func setVisualScheme() {
       selectedWheel = selectorBeforeAfter.selectedSegmentIndex == 1  ? wheelAfter : wheelBefore
       
        // set HubSize
        hubImageHeight.constant = CGFloat(selectedWheel.rimSizeMM  * scaleCoefficient * 1.01)
        
        // set brake size
        brakeRotorSize.constant = CGFloat(wheelBefore.rimSizeMM  * scaleCoefficient)
        
        // set rimSize (vertical constraint)
        rimUpperPartVerticalPos.constant = CGFloat(selectedWheel.rimSizeMM * scaleCoefficient * 0.5)
        rimLowerPartVerticalPos.constant = -CGFloat(selectedWheel.rimSizeMM * scaleCoefficient * 0.5)
        
        // set rimOffset (horzontal constraint)
        rimUpperPartOffset.constant = CGFloat(5.0 + selectedWheel.rimOffset  * scaleCoefficient)
        
        // set rimWidth
        rimUpperPartWidth.constant = CGFloat(selectedWheel.rimWidthMM * scaleCoefficient)
        
        // set tyreHeight
        tyreUpperPartHeight.constant = CGFloat(selectedWheel.tyreHeightMM * scaleCoefficient)
        
        // set tyreWidths
        tyreUpperPartWidth.constant = CGFloat(selectedWheel.tyreWidth * scaleCoefficient)
        rimFillerWidth.constant = min(tyreUpperPartWidth.constant, rimUpperPartWidth.constant - 7)
        
        // round corners
        rimUpperPart.layer.cornerRadius = rimUpperPart.frame.height / 1.8
        rimUpperPart.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        rimUpperFiller.layer.cornerRadius = rimUpperPart.frame.height
        rimUpperFiller.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        rimUpperFillerWhiteInside.layer.cornerRadius = rimUpperPart.frame.height
        rimUpperFillerWhiteInside.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        rimLowerPart.layer.cornerRadius = rimLowerPart.frame.height / 1.8
        rimLowerPart.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        rimLowerFiller.layer.cornerRadius = rimLowerPart.frame.height
        rimLowerFiller.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        rimLowerFillerWhiteInside.layer.cornerRadius = rimLowerPart.frame.height
        rimLowerFillerWhiteInside.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        tyreUpperPart.layer.cornerRadius = tyreUpperPartHeight.constant / 2.5
        tyreLowerPart.layer.cornerRadius = tyreUpperPartHeight.constant / 2.5
    }
    
    private func setLabels() {
        // set scheme labels
        wheelSizeLabel.text = "\(Int(selectedWheel.totalWheelDiameter)) mm"
        tyreWidthLabel.text = "\(Int(selectedWheel.tyreWidth)) mm"
        tyreHeightLabelMM.text = "\(Int(selectedWheel.tyreHeightMM)) mm"
        rimWidthLabelMM.text = "\(Int(selectedWheel.rimWidthMM)) mm"
        
        // set right side labels
        rimSizeLabel.text = "Rim size:\n\(Int(selectedWheel.rimSize)) inches"
        rimWidthLabelInch.text = "Rim width:\n\(Float(selectedWheel.rimWidth)) inches"
        rimOffsetLabel.text = "Rim offset:\n\(Int(selectedWheel.rimOffset)) mm"
        
        // set left side labels
        tireWidthLabel.text = "Tyre width:\n\(Int(selectedWheel.tyreWidth)) mm"
        tyreHeightLabel.text = "Tyre height:\n\(Int(selectedWheel.tyreHeight)) %"
        tyreCircumference.text = "Circumference:\n\(Int(selectedWheel.totalWheelCircle)) mm"
    }
    

    // MARK: IB Actions
    @IBAction func selectorBeforeAfterActivated(_ sender: Any) {
        selectedWheel = selectorBeforeAfter.selectedSegmentIndex == 1  ? wheelAfter : wheelBefore
        setVisualScheme()
        setLabels()
        
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
        cell.contentConfiguration = content
        return cell
    }
}

