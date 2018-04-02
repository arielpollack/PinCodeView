//
//  PinCodeDigitView.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 03/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

public protocol PinCodeDigitView: class {
    init()
    var digit: String? { get set }
    var state: PinCodeDigitViewState! { get set }
    func configure(withState: PinCodeDigitViewState)
    
    // hackish way to constraint to UIView only
    var view: UIView { get }
}

public extension PinCodeDigitView where Self: UIView {
    var view: UIView {
        return self
    }
}
