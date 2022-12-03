//
//  ResultsViewController.swift
//  TyreCalculator
//
//  Created by MacBook Air 13 on 03.12.2022.
//

import UIKit

class ResultsViewController: UIViewController {

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
