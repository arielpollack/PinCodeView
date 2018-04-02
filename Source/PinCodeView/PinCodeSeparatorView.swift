//
//  PinCodeSeparatorView.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

class PinCodeSeparatorView: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: 30)
        self.textAlignment = .center
        self.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
