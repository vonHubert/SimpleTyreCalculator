//
//  ResultsViewController.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 03.12.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet var resultsTableView: UITableView!
    
    @IBOutlet var hubImageHeight: NSLayoutConstraint!
    
    @IBOutlet var suspensionImage: UIImageView!
    

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.dataSource = self
        generateResults()
        setVisual()
    }
    
    func setVisual() {
        var scaleCoefficient: CGFloat = suspensionImage.frame.width / 390.0
        hubImageHeight.constant = 110.0 * scaleCoefficient
        print(scaleCoefficient)
    }
    
    func generateResults() {
        results.append(ResultsMessage(
            title: "Spidometer:",
            message: "\(WheelSet.compareSpidometer(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))")
        )
        results.append(ResultsMessage(
            title: "Wheel size fitment:",
            message: "\(WheelSet.checkTyreDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))")
        )
        results.append(ResultsMessage(
            title: "Rim diameter fitment:",
            message: "\(WheelSet.checkRimDiameterFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))")
        )
        results.append(ResultsMessage(
            title: "Tyre to rim fitment:",
            message: "\(WheelSet.checkTireWidthFitment(wheelSetInput: wheelAfter))")
        )
        results.append(ResultsMessage(
            title: "Suspension fitment:",
            message: "\(WheelSet.checkInnerWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))")
        )
        results.append(ResultsMessage(
            title: "Fender fitment:",
            message: "\(WheelSet.checkOuterWheelFitment(wheelBeforeInput: wheelBefore, wheelAfterInput: wheelAfter))")
        )
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
        let result = results[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = result.title
        content.secondaryText = result.message
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
