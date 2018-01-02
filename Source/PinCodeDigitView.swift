//
//  PinCodeDigitView.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 03/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

public protocol PinCodeDigitView: class where Self: UIView  {
    var digit: String? { get set }
    var state: PinCodeDigitViewState! { get set }
    func configure(withState: PinCodeDigitViewState)
}
