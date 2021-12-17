//
//  DemoKeyboardLayoutProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific layout provider adds a locale picker nest
 next to the space bar.
 */
class DemoKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        var rows = layout.items
        guard rows.count > 0, context.locales.count > 1 else { return layout }
        let rowIndex = rows.count - 1
        guard let system = (rows[rowIndex].first { $0.action.isSystemAction }) else { return layout }
        let switcher = KeyboardLayoutItem(action: .nextLocale, size: system.size, insets: system.insets)
        rows.insert(switcher, after: .space, atRow: rowIndex)
        return KeyboardLayout(items: rows)
    }
}
