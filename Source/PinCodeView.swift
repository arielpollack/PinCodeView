//
//  PinCodeView.swift
//  PinCodeView
//
//  Created by Ariel Pollack on 02/04/2017.
//  Copyright © 2017 Dapulse. All rights reserved.
//

import UIKit

class PinCodeView: UIControl {

    enum TextType {
        case numbers
        case numbersAndLetters
    }

    var textType: TextType = .numbers
    @IBInspectable var numberOfDigits: Int = 6
    @IBInspectable var groupingSize: Int = 3
    @IBInspectable var spacing: Int = 2
    var viewConfig: PinCodeDigitView.ViewConfigBlock = { state, view in
        // default implementation
        view.layer.borderWidth = 1
        view.font = UIFont.systemFont(ofSize: 20)

        switch state {
        case .empty, .hasDigit:
            view.layer.borderColor = UIColor.blue.cgColor

        case .failedVerification:
            view.layer.borderColor = UIColor.red.cgColor
        }
    }

    fileprivate lazy var digitStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = CGFloat(self.spacing)
        sv.distribution = .fillEqually
        return sv
    }()
    fileprivate var digitViews = [PinCodeDigitView]()

    init(numberOfDigits: Int = 6, textType: TextType = .numbers, groupingSize: Int = 3, spacing: Int = 2) {
        super.init(frame: .zero)

        self.numberOfDigits = numberOfDigits
        self.textType = textType
        self.groupingSize = groupingSize
        self.spacing = spacing

        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        addSubview(digitStackView)
        digitStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        digitStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        digitStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        digitStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        for _ in 0..<numberOfDigits {
            let digitView = PinCodeDigitView(viewConfig: self.viewConfig)
            digitView.translatesAutoresizingMaskIntoConstraints = false
            digitStackView.addArrangedSubview(digitView)
            digitViews.append(digitView)
        }

        // TODO: handle separators

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        longPress.minimumPressDuration = 0.25
        addGestureRecognizer(longPress)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        
    }

    func didTap() {
        guard !self.isFirstResponder else { return }
        becomeFirstResponder()
    }

    func didLongPress(gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }

        if !self.isFirstResponder  {
            self.becomeFirstResponder()
        }

        UIMenuController.shared.setTargetRect(self.bounds, in: self)
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }

    // MARK: handle text input
    fileprivate var currentDigitIndex = 0
    fileprivate var text: String {
        return digitViews.reduce("", { text, digitView in
            return text + (digitView.digit ?? "")
        })
    }

    func clearText() {
        currentDigitIndex = 0
        for digitView in digitViews {
            digitView.digit = nil
        }
    }

    func submitDigits() {

    }
}

extension PinCodeView {
    override func paste(_ sender: Any?) {
        guard let string = UIPasteboard.general.string else { return }
        let text: String
        switch textType{
        case .numbers:
            text = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        case .numbersAndLetters:
            text = string.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
        }

        insertText(text)
    }

    override var canBecomeFirstResponder: Bool { return true }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) { return true }
        return false
    }

    var keyboardType: UIKeyboardType {
        get {
            switch textType {
            case .numbers:
                return .numberPad
            case .numbersAndLetters:
                return .default
            }
        }
        set {}
    }
}

extension PinCodeView: UIKeyInput {
    public var hasText: Bool {
        return text.characters.count > 0
    }

    public func insertText(_ text: String) {
        guard text.characters.count == 1 else {
            clearText()
            text.characters.map({ "\($0)" }).forEach(insertText)
            return
        }
        guard currentDigitIndex < numberOfDigits else { return }

        let digitView = digitViews[currentDigitIndex]
        digitView.digit = text

        currentDigitIndex += 1

        if currentDigitIndex == numberOfDigits {
            submitDigits()
        }
    }

    public func deleteBackward() {
        guard currentDigitIndex > 0 else { return }

        let digitView = digitViews[currentDigitIndex-1]
        digitView.digit = nil
        
        currentDigitIndex -= 1
    }
}
