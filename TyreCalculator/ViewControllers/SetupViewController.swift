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
    
    @IBOutlet var rimWidthPickerBefore: UIPickerView!
    @IBOutlet var rimWidthPickerAfter: UIPickerView!
    
    @IBOutlet var rimOffsetPickerBefore: UIPickerView!
    @IBOutlet var rimOffsetPickerAfter: UIPickerView!
    
    @IBOutlet var tyreWidthPickerBefore: UIPickerView!
    @IBOutlet var tyreWidthPickerAfter: UIPickerView!
    
    @IBOutlet var tyreHeigthPickerBefore: UIPickerView!
    @IBOutlet var tyreHeigthPickerAfter: UIPickerView!
    
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
        
        rimWidthPickerBefore.dataSource = self
        rimWidthPickerBefore.delegate = self
        rimWidthPickerAfter.dataSource = self
        rimWidthPickerAfter.delegate = self
        
        rimOffsetPickerBefore.dataSource = self
        rimOffsetPickerBefore.delegate = self
        rimOffsetPickerAfter.dataSource = self
        rimOffsetPickerAfter.delegate = self
        
        tyreWidthPickerBefore.dataSource = self
        tyreWidthPickerBefore.delegate = self
        tyreWidthPickerAfter.dataSource = self
        tyreWidthPickerAfter.delegate = self
        
        tyreHeigthPickerBefore.dataSource = self
        tyreHeigthPickerBefore.delegate = self
        tyreHeigthPickerAfter.dataSource = self
        tyreHeigthPickerAfter.delegate = self
        
        
    }
    
    let sizeMultiplier:CGFloat = 50
    

    var rimSizesData = PickerData.getRimSizesData()
    var rimWidthsData = PickerData.getRimWidthsData()
    var rimOffsetsData = PickerData.getRimOffsetsData()
    var tyreWidthsData = PickerData.getTyreWidthsData()
    var tyreHeightsData = PickerData.getTyreHeigthsData()
    
}

extension SetupViewController:UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case rimSizePickerBefore, rimSizePickerAfter: return rimSizesData.count
        case rimWidthPickerBefore, rimWidthPickerAfter: return rimWidthsData.count
        case rimOffsetPickerBefore, rimOffsetPickerAfter: return rimOffsetsData.count
        case tyreWidthPickerBefore, tyreWidthPickerAfter: return tyreWidthsData.count
        default: return tyreHeightsData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case rimSizePickerBefore, rimSizePickerAfter: return rimSizesData[row]
        case rimWidthPickerBefore, rimWidthPickerAfter: return rimWidthsData[row]
        case rimOffsetPickerBefore, rimOffsetPickerAfter: return rimOffsetsData[row]
        case tyreWidthPickerBefore, tyreWidthPickerAfter: return tyreWidthsData[row]
        default: return tyreHeightsData[row]
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
