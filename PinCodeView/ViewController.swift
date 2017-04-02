//
//  ViewController.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pinView: PinCodeView! { didSet { pinView.delegate = self } }
}

extension ViewController: PinCodeViewDelegate {
    func pinCodeView(view: PinCodeView, didSubmitPinCode code: String, isValidCallback callback: @escaping (Bool) -> Void) {

        view.alpha = 0.5
        view.isEnabled = false

        // check server for code validity, etc
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            view.alpha = 1
            view.isEnabled = true

            callback(false)
        }
    }
}

