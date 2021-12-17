//
//  DemoAppearance.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific appearance inherits the standard one and
 can be used to easily customize the demo keyboard.
 
 The appearance is registered by `KeyboardViewController` to
 show you how to can register your own appearance.
 */
class DemoAppearance: StandardKeyboardAppearance {
    
    override func buttonImage(for action: KeyboardAction) -> Image? {
        super.buttonImage(for: action)
    }
    
    override func buttonText(for action: KeyboardAction) -> String? {
        super.buttonText(for: action)
    }

    override func inputCalloutStyle() -> InputCalloutStyle {
        var style = super.inputCalloutStyle()
        style.callout.backgroundColor = .red
        style.calloutSize.width = 100
        style.callout.borderColor = .blue
        return style
    }
    
    override func secondaryInputCalloutStyle() -> SecondaryInputCalloutStyle {
        let style = super.secondaryInputCalloutStyle()
        return style
    }
    
    override func systemKeyboardButtonStyle(
        for action: KeyboardAction,
        isPressed: Bool) -> SystemKeyboardButtonStyle {
        var style = super.systemKeyboardButtonStyle(for: action, isPressed: isPressed)
            style.foregroundColor = .blue
        return style
    }
}
