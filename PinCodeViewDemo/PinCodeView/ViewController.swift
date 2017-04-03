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
}

extension ViewController: PinCodeViewDelegate {
    func pinCodeView(_ view: PinCodeView, didSubmitPinCode code: String, isValidCallback callback: @escaping (Bool) -> Void) {
        
        view.alpha = 0.5
        
        // check server for code validity, etc
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            view.alpha = 1
            
            callback(false)
        }
    }
}

