//
//  EmojiTextField.swift
//  MySpendings
//
//  Created by Mohamed on 07/01/2023.
//

import Foundation

import UIKit

// implemented from https://handyopinion.com/uitextfield-for-emoji-input-unchangeable-keyboard-type-in-swift-ios/

class EmojiTextField: UITextField {

       // required for iOS 13
       override var textInputContextIdentifier: String? { "" }

        override var textInputMode: UITextInputMode? {
            for mode in UITextInputMode.activeInputModes {
                if mode.primaryLanguage == "emoji" {
                    return mode
                }
            }
            return nil
        }

    override init(frame: CGRect) {
            super.init(frame: frame)

            commonInit()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)

             commonInit()
        }

        func commonInit() {
            NotificationCenter.default.addObserver(self, selector: #selector(inputModeDidChange), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
        }

        @objc func inputModeDidChange(_ notification: Notification) {
            guard isFirstResponder else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.reloadInputViews()
            }
        }
    }
