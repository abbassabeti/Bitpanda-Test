//
//  Locale+Extension.swift
//  BitPandaTest
//
//  Created by Abbas on 2/13/21.
//

import Foundation
extension Locale {
    static func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
