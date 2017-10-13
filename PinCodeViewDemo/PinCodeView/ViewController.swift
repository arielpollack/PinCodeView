//
//  ViewController.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pinView: PinCodeView! {
        didSet {
            pinView.delegate = self
            pinView.numberOfDigits = 6
            pinView.groupingSize = 0
            pinView.itemSpacing = 7
            pinView.digitViewInit = PinCodeDigitSquareView.init
        }
    }
	
	@IBOutlet weak var pinView2: PinCodeView! {
		didSet {
			pinView2.delegate = self
			pinView2.numberOfDigits = 4
			pinView2.groupingSize = 0
			pinView2.itemSpacing = 10
			pinView2.distribution = .fillEqually
			pinView2.digitViewInit = PinCodeDigitField.init
		}
	}

}

extension ViewController: PinCodeViewDelegate {
    @objc func pinCodeView(_ view: PinCodeView, didSubmitPinCode code: String, isValidCallback callback: @escaping (Bool) -> Void) {
        
        view.alpha = 0.5
        
        // check server for code validity, etc
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            view.alpha = 1
            
            callback(false)
        }
    }
}

