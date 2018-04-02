//
//  ViewController.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit
import PinCodeView
import RxSwift
import RxCocoa

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

class RxViewController: ViewController {

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        pinView.rx
            .didSubmit
            .subscribe(onNext: { [weak self] code in
                self?.submit(code: code)
        })
        .disposed(by: disposeBag)
    }

    fileprivate func submit(code: String) {

    }
}

extension ViewController: PinCodeViewDelegate {
    func pinCodeView(_ view: PinCodeView, didInsertText text: String) {
        
    }

    func pinCodeView(_ view: PinCodeView, didSubmitPinCode code: String, isValidCallback callback: @escaping (Bool) -> Void) {
        
        view.alpha = 0.5
        
        // check server for code validity, etc
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            view.alpha = 1
            
            callback(false)
        }
    }
}

