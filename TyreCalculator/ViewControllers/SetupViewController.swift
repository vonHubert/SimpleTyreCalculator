//
//  ViewController.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 02.12.2022.
//

import UIKit

class SetupViewController: UIViewController {

    
    @IBOutlet var rimSizePickerBefore: UIPickerView!
    @IBOutlet var rimSizePickerAfter: UIPickerView!
    
    // MARK: Variables
    var wheelBefore: WheelSet = WheelSet(
        rimSize: 15,
        rimWidth: 7.5,
        rimOffset: 45,
        tyreWidth: 225,
        tyreHeight: 55
    )

    var wheelAfter: WheelSet = WheelSet(
        rimSize: 15,
        rimWidth: 7.5,
        rimOffset: 45,
        tyreWidth: 225,
        tyreHeight: 55
    )

    
    override func viewDidLoad() {
        super.viewDidLoad()
        rimSizePickerBefore.dataSource = self
        rimSizePickerBefore.delegate = self
        rimSizePickerAfter.dataSource = self
        rimSizePickerAfter.delegate = self
    }
    
    let sizeMultiplier:CGFloat = 50
    
   
    var rimSizesData = PickerData.getRimSizeData()
    
}

extension SetupViewController:UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case rimSizePickerBefore, rimSizePickerAfter: return rimSizesData.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case rimSizePickerBefore, rimSizePickerAfter: return rimSizesData[row]
        default: return ""
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch pickerView {
//        case rimSizePickerBefore: rimSizeBeforeLabel.text = rimSizesData[row]
//        default: rimSizeAfterLabel.text = rimSizesData[row]
//        }
//    }
    
}
    
    
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
