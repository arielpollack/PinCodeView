//
//  PinCodeDigitSquareView.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

public class PinCodeDigitSquareView: UILabel, PinCodeDigitView {
    
    public var state: PinCodeDigitViewState! {
        didSet {
            if state != oldValue {
                configure(withState: state)
            }
        }
    }
    
    public var digit: String? {
        didSet {
            guard digit != oldValue else { return }
            self.state = digit != nil ? .hasDigit : .empty
            self.text = digit
        }
    }
    
    convenience required public init() {
        self.init(frame: .zero)
        
        self.textAlignment = .center
        self.layer.borderWidth = 1
        self.font = UIFont.systemFont(ofSize: 20)
        self.state = .empty
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    public func configure(withState state: PinCodeDigitViewState) {
        font = UIFont.systemFont(ofSize: 30)
        layer.borderWidth = 2
        layer.cornerRadius = 3
        textColor = UIColor(colorLiteralRed: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
        
        switch state {
        case .empty:
            layer.borderColor = UIColor(colorLiteralRed: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1).cgColor
            
        case .hasDigit:
            layer.borderColor = UIColor(colorLiteralRed: 0, green: 161.0/255.0, blue: 230.0/255.0, alpha: 1).cgColor
            
        case .failedVerification:
            layer.borderColor = UIColor(colorLiteralRed: 246.0/255.0, green: 95.0/255.0, blue: 124.0/255.0, alpha: 1).cgColor
        }
    }
}
