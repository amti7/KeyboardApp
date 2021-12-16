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
    private let buttonStackView = UIStackView()
    
    private let keyboardEnabledLabel = UILabel()
    private let keyboardFullAxcessEnabledLabel = UILabel()

    
    private let lightButton = UIButton()
    private let darkButton = UIButton()
    
    let keyboardState = KeyboardEnabledState(bundleId: C.keyboardKitBundleID)
    
    var appearance: UIKeyboardAppearance = .dark

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews()
        setupTextField()
        setupStackView()
        setupKeyboardEnabledLabel()
        setupKeyboardFullAxcess()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkIfKeyboardEnabled()
    }
    
    private func addSubviews() {
        [mainTextField, buttonStackView, keyboardEnabledLabel, keyboardFullAxcessEnabledLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [lightButton, darkButton].forEach {
            buttonStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = C.cornerRadiusValue
            $0.layer.borderWidth = C.borderWidthValue
        }
    }
    
    private func setupKeyboardEnabledLabel() {
        checkIfKeyboardEnabled()
        
        keyboardEnabledLabel.textAlignment = .center
        keyboardEnabledLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: C.keyboardLabelTopOffset).isActive = true
        keyboardEnabledLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.sideOffset).isActive = true
        keyboardEnabledLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -C.sideOffset).isActive = true
        keyboardEnabledLabel.heightAnchor.constraint(equalToConstant: C.keyboardLabelHeight).isActive = true
    }
    
    private func checkIfKeyboardEnabled() {
        if keyboardState.isKeyboardEnabled {
            keyboardEnabledLabel.text = "Keyboard is Enabled V"
            keyboardEnabledLabel.textColor = .systemGreen
        } else {
            keyboardEnabledLabel.text = "Keyboard is Disabled X"
            keyboardEnabledLabel.textColor = .systemRed
        }
    }
    
    private func setupKeyboardFullAxcess() {
        if keyboardState.isFullAccessEnabled {
            keyboardFullAxcessEnabledLabel.text = "Full Axcess Keyboard Enabled V"
            keyboardFullAxcessEnabledLabel.textColor = .systemGreen
        } else {
            keyboardFullAxcessEnabledLabel.text = "Full Axcess Keyboard Disabled X"
            keyboardFullAxcessEnabledLabel.textColor = .systemRed
        }
        
        
        
        keyboardFullAxcessEnabledLabel.textAlignment = .center
        keyboardFullAxcessEnabledLabel.topAnchor.constraint(equalTo: keyboardEnabledLabel.bottomAnchor, constant: C.keyboardLabelTopOffset).isActive = true
        keyboardFullAxcessEnabledLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.sideOffset).isActive = true
        keyboardFullAxcessEnabledLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -C.sideOffset).isActive = true
        keyboardFullAxcessEnabledLabel.heightAnchor.constraint(equalToConstant: C.keyboardLabelHeight).isActive = true
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
    
    private func setupStackView() {
        buttonStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: C.topStackViewOffset).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.sideOffset).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -C.sideOffset).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: C.stackViewHeight).isActive = true
        
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = C.stackViewSpacing
    }
    
    private func setupButtons() {
        lightButton.layer.borderColor = UIColor.black.cgColor
        lightButton.setTitle(C.lightModeString, for: .normal)
        lightButton.setTitleColor(.black, for: .normal)
        lightButton.addTarget(self, action: #selector(lightModeTapped), for: .touchUpInside)
        
        darkButton.backgroundColor = .black
        darkButton.setTitle(C.darkModeString, for: .normal)
        darkButton.setTitleColor(.white, for: .normal)
        darkButton.addTarget(self, action: #selector(darkModeTapped), for: .touchUpInside)
    }
    
    @objc private func darkModeTapped() {
        appearance = .dark
    }
    
    @objc private func lightModeTapped() {
        appearance = .light
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
        static let topStackViewOffset: CGFloat = 64
        static let stackViewHeight: CGFloat = 70
        static let stackViewSpacing: CGFloat = 16
        
        static let keyboardLabelHeight: CGFloat = 50
        static let keyboardLabelTopOffset: CGFloat = 8
        
        static let keyboardKitBundleID: String = "com.dot.KeyboardApp.Keyboard"
        static let lightModeString: String = "Light Mode"
        static let darkModeString: String = "Dark Mode"
        
        
    }
}
