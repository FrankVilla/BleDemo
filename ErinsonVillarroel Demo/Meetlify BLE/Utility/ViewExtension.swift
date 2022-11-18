//
//  ViewExtension.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 15/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
            if hidden {
                if !remove {
                    self.hidden()
                }
            } else {
                self
            }
        }
}
