//
//  String+Localizable.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation

extension String {
    public var localized: String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: "Localizable")
    }
}
