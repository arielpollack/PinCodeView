//
//  PinCodeDigitField.swift
//  PinCodeView
//
//  Created by Jim Boyd on 05/18/2017.
//  Copyright © 2017 Cabosoft. All rights reserved.
//
//  Modeled after PinCodeDigitSquareView.swift
//  Copyright © 2017 Dapulse. All rights reserved.
//  https://github.com/DaPulse/PinCodeView/blob/master/PinCodeViewDemo/PinCodeView/PinCodeDigitSquareView.swift
//

import UIKit
import PinCodeView

public class PinCodeDigitField: UITextField, PinCodeDigitView {

    public var viewState: PinCodeDigitViewState! = .empty {
        didSet {
            if viewState != oldValue {
                configure(withState: viewState)
            }
        }
    }

    @objc public var digit: String? {
        didSet {
            guard digit != oldValue else { return }
            self.viewState = digit != nil ? .hasDigit : .empty
            self.text = digit
        }
    }

    convenience required public init() {
        self.init(frame: .zero)

		self.isUserInteractionEnabled = false
		self.isSecureTextEntry = true

        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 30)
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 5
		self.layer.masksToBounds = true

		translatesAutoresizingMaskIntoConstraints = false
		widthAnchor.constraint(equalToConstant: 40).isActive = true

		self.textColor = UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1)
		self.backgroundColor = UIColor.white

		self.configure(withState: .empty)
    }

    public func configure(withState state: PinCodeDigitViewState) {
        switch state {
        case .empty:
            layer.borderColor = UIColor(red: 202.0 / 255.0, green: 202.0 / 255.0, blue: 202.0 / 255.0, alpha: 1).cgColor

        case .hasDigit:
            layer.borderColor = UIColor(red: 0, green: 161.0 / 255.0, blue: 230.0 / 255.0, alpha: 1).cgColor

        case .failedVerification:
            layer.borderColor = UIColor(red: 246.0 / 255.0, green: 95.0 / 255.0, blue: 124.0 / 255.0, alpha: 1).cgColor
        }
    }
}
