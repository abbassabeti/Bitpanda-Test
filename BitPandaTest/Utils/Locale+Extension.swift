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
        guard preferredIdentifier != "en" else {return Locale(identifier: "en_US")}
        return Locale(identifier: preferredIdentifier)
    }
}
