//
//  PinCodeView+Rx.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 29/06/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
#if !COCOAPODS
import PinCodeView
#endif

fileprivate class PinCodeViewDelegateProxy: PinCodeViewDelegate {

    weak var delegate: PinCodeViewDelegate?
    internal var didSubmit = PublishSubject<String>()
    internal var submitCodeCallback: ((Bool)->Void)?

    init(pinCodeView view: PinCodeView) {
        self.delegate = view.delegate
    }

    func pinCodeView(_ view: PinCodeView, didSubmitPinCode code: String, isValidCallback callback: @escaping (Bool)->Void) {
        submitCodeCallback = callback
        didSubmit.onNext(code)
        self.delegate?.pinCodeView(view, didSubmitPinCode: code, isValidCallback: callback)
    }

    func pinCodeView(_ view: PinCodeView, didInsertText text: String) {
        self.delegate?.pinCodeView(view, didInsertText: text)
    }
}

extension Reactive where Base: PinCodeView {

    public var didSubmit: Observable<String> {
        let delegateProxy = PinCodeViewDelegateProxy(pinCodeView: base)
        base.delegate = delegateProxy
        return delegateProxy.didSubmit.asObservable()
    }
}
