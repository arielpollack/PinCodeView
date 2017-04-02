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
            pinView.groupingSize = 3
            pinView.itemSpacing = 7
            pinView.viewConfig = { state, view in
                view.font = UIFont.systemFont(ofSize: 30)
                view.layer.borderWidth = 2
                view.layer.cornerRadius = 3
                view.textColor = UIColor(colorLiteralRed: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
                view.widthAnchor.constraint(equalToConstant: 45).isActive = true
                
                switch state {
                case .empty:
                    view.layer.borderColor = UIColor(colorLiteralRed: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1).cgColor
                    
                case .hasDigit:
                    view.layer.borderColor = UIColor(colorLiteralRed: 0, green: 161.0/255.0, blue: 230.0/255.0, alpha: 1).cgColor
                    
                case .failedVerification:
                    view.layer.borderColor = UIColor(colorLiteralRed: 246.0/255.0, green: 95.0/255.0, blue: 124.0/255.0, alpha: 1).cgColor
                }
            }
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

