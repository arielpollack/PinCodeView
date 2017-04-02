//
//  PinCodeDigitView.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

public class PinCodeDigitView: UILabel {
    
    public typealias ViewConfigBlock = (State, PinCodeDigitView)->()
    
    public enum State {
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
    
    convenience init(viewConfig: @escaping ViewConfigBlock) {
        self.init(frame: .zero)
        self.viewConfig = viewConfig
        self.textAlignment = .center
        self.configure()
    }
    
    private func configure() {
        self.viewConfig(state, self)
    }
}
