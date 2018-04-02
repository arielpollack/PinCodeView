//
//  PinCodeViewDelegate.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

@objc public protocol PinCodeViewDelegate: class {
    func pinCodeView(_ view: PinCodeView, didSubmitPinCode code: String, isValidCallback callback: @escaping (Bool)->Void)
    func pinCodeView(_ view: PinCodeView, didInsertText text: String)
}

extension PinCodeViewDelegate {
    func pinCodeView(_ view: PinCodeView, didInsertText text: String) {}
}
