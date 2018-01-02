//
//  PinCodeDigitSquareView.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

public class PinCodeDigitSquareView: UILabel, PinCodeDigitView {
    
    public var state: PinCodeDigitViewState! = .empty {
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
        self.font = UIFont.systemFont(ofSize: 30)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 3
        self.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.configure(withState: .empty)
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    public func configure(withState state: PinCodeDigitViewState) {
        switch state {
        case .empty:
            layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1).cgColor
            
        case .hasDigit:
            layer.borderColor = #colorLiteral(red: 0, green: 0.631372549, blue: 0.9019607843, alpha: 1).cgColor
            
        case .failedVerification:
            layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.3725490196, blue: 0.4862745098, alpha: 1).cgColor
        }
    }
}
