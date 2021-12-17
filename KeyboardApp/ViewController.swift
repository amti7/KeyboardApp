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
    private let settingsButton = UIButton()
    private let buttonImage = UIImageView()
    
    private var willEnterForegroundNotification: NSObjectProtocol?
    
    var keyboardState = KeyboardEnabledState(bundleId: C.newKeyboardKitBundleID)
    
    var appearance: UIKeyboardAppearance = .default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupObservers()
        addSubviews()
        setupTextField()
        setupKeyboardEnabledLabel()
        setupSettingsButton()
        
        
    }
    
    private func setupObservers() {
        willEnterForegroundNotification = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardState = KeyboardEnabledState(bundleId: C.newKeyboardKitBundleID)
            self?.checkIfKeyboardEnabled()
        }
    }
    
    private func addSubviews() {
        [mainTextField, keyboardEnabledLabel, settingsButton].forEach {
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
        if keyboardState.isKeyboardEnabled {
            keyboardEnabledLabel.text = C.keyboardEnabledString
            keyboardEnabledLabel.textColor = .systemGreen
        } else {
            keyboardEnabledLabel.text = C.keyboardDisabledString
            keyboardEnabledLabel.textColor = .systemRed
        }
    }
    
    private func setupSettingsButton() {
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsButton.topAnchor.constraint(equalTo: keyboardEnabledLabel.bottomAnchor, constant: C.sideOffset).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: C.heightTextfieldOffset).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: C.widthTextfieldOffet).isActive = true
        
        settingsButton.backgroundColor = .systemGray2
        settingsButton.layer.cornerRadius = C.cornerRadiusValue
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        
        settingsButton.addSubview(buttonImage)
        setupButtonImage()
        
    }
    
    private func setupButtonImage() {
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        buttonImage.centerXAnchor.constraint(equalTo: settingsButton.centerXAnchor).isActive = true
        buttonImage.centerYAnchor.constraint(equalTo: settingsButton.centerYAnchor).isActive = true
        buttonImage.heightAnchor.constraint(equalToConstant: C.buttonImageSize).isActive = true
        buttonImage.widthAnchor.constraint(equalToConstant: C.buttonImageSize).isActive = true
        
        buttonImage.image = UIImage(named: C.settingsIconString)
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
    
    @objc private func openSettings() {
        guard let url = URL(string: C.keyboardSetttingsPrefs) else { return}
        
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
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
        
        static let buttonImageSize: CGFloat = 30
        
        static let keyboardLabelHeight: CGFloat = 50
        static let keyboardLabelTopOffset: CGFloat = 32
        static let newKeyboardKitBundleID: String = "com.dot.KeyboardApp.SomeKeyboard"
        static let lightModeString: String = "Light Mode"
        static let darkModeString: String = "Dark Mode"
        static let keyboardEnabledString: String = "Keyboard is Enabled V"
        static let keyboardDisabledString: String = "Keyboard is Disabled X"
        static let keyboardSetttingsPrefs: String = "App-prefs:General&path=Keyboard"
        static let settingsIconString: String = "settingsIcon"
    }
}
