//
//  TextFieldModifier.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 07/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import SwiftUI

struct PlaceHolder<T: View>: ViewModifier {
    var placeHolder: T
    var show: Bool
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show { placeHolder }
            content
        }
    }
}

extension View {
    func placeHolder<T:View>(_ holder: T, show: Bool) -> some View {
        self.modifier(PlaceHolder(placeHolder:holder, show: show))
    }
}
