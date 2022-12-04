//
//  ResultsViewController.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 03.12.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet var resultsLabel: UILabel!
    @IBOutlet var resultsTableView: UITableView!
    
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
    
    var results:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.dataSource = self
        generateResults()
    }
    
    func generateResults() {
        results = [
            "Spidometer:":"\(WheelSet.compareSpidometer(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))",
            "Wheel size fitment:":"\(WheelSet.checkTyreDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))",
            "Rim diameter fitment:":"\(WheelSet.checkRimDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))",
            "Tyre to rim fitment:":"\(WheelSet.checkTireWidthFitment(wheelSetInput: wheelAfter))",
            "Suspension fitment:":"\(WheelSet.checkInnerWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))",
            "Fender fitment:":"\(WheelSet.checkOuterWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))"
        ]
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath)
        let title = Array(results.keys)[indexPath.row]
        let message = Array(results.values)[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = title
        content.secondaryText = message
        cell.contentConfiguration = content
        return cell
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
