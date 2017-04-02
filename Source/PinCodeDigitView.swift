//
//  PinCodeDigitView.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

class PinCodeDigitView: UILabel {

    typealias ViewConfigBlock = (State, PinCodeDigitView)->()

    enum State {
        case empty
        case hasDigit
        case failedVerification
    }

    var viewConfig: ViewConfigBlock! { didSet { configure() } }
    var state: State = .empty {
        didSet {
            if state != oldValue {
                configure()
            }
        }
    }
    var digit: String? {
        didSet {
            guard digit != oldValue else { return }
            self.state = digit != nil ? .hasDigit : .empty
            self.text = digit
        }
    }

    init(viewConfig: @escaping ViewConfigBlock) {
        super.init(frame: .zero)
        self.viewConfig = viewConfig
        self.textAlignment = .center
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.viewConfig(state, self)
    }
}
