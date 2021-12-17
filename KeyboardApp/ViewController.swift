//
//  ViewController.swift
//  KeyboardApp
//
//  Created by Kamil on 07/12/2021.
//

import UIKit
import KeyboardKit

final class ViewController: UIViewController {
    
    private let mainTextField = UITextField()
    private let keyboardEnabledLabel = UILabel()
    
    private var willEnterForegroundNotification: NSObjectProtocol?
    
    let keyboardState = KeyboardEnabledState(bundleId: C.newKeyboardKitBundleID)
    
    var appearance: UIKeyboardAppearance = .default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupObservers()
        addSubviews()
        setupTextField()
        setupKeyboardEnabledLabel()
    }
    
    private func setupObservers() {
        willEnterForegroundNotification = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] notification in
            self?.checkIfKeyboardEnabled()
        }
    }
    
    private func addSubviews() {
        [mainTextField, keyboardEnabledLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupKeyboardEnabledLabel() {
        checkIfKeyboardEnabled()
        
        keyboardEnabledLabel.textAlignment = .center
        keyboardEnabledLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: C.keyboardLabelTopOffset).isActive = true
        keyboardEnabledLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.sideOffset).isActive = true
        keyboardEnabledLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -C.sideOffset).isActive = true
        keyboardEnabledLabel.heightAnchor.constraint(equalToConstant: C.keyboardLabelHeight).isActive = true
    }
    
    private func checkIfKeyboardEnabled() {
//        print("(*) enabled:", keyboardState.isKeyboardEnabled)
        if keyboardState.isKeyboardEnabled {
            keyboardEnabledLabel.text = "Keyboard is Enabled V"
            keyboardEnabledLabel.textColor = .systemGreen
        } else {
            keyboardEnabledLabel.text = "Keyboard is Disabled X"
            keyboardEnabledLabel.textColor = .systemRed
        }
    }
    
    private func setupTextField() {
        mainTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainTextField.heightAnchor.constraint(equalToConstant: C.heightTextfieldOffset).isActive = true
        mainTextField.widthAnchor.constraint(equalToConstant: C.widthTextfieldOffet).isActive = true
        
        mainTextField.layer.borderWidth = C.borderWidthValue
        mainTextField.layer.cornerRadius = C.cornerRadiusValue
        mainTextField.textAlignment = .center
        mainTextField.textColor = .black
    }
}

extension ViewController {
    // Constants
    private struct C {
        static let heightTextfieldOffset: CGFloat = 50
        static let widthTextfieldOffet: CGFloat = 150
        static let cornerRadiusValue: CGFloat = 10
        static let borderWidthValue: CGFloat = 1.0
        static let sideOffset: CGFloat = 16
        
        static let keyboardLabelHeight: CGFloat = 50
        static let keyboardLabelTopOffset: CGFloat = 32
        static let newKeyboardKitBundleID: String = "com.dot.KeyboardApp.SomeKeyboard"
        
        static let lightModeString: String = "Light Mode"
        static let darkModeString: String = "Dark Mode"
        
        
    }
}
