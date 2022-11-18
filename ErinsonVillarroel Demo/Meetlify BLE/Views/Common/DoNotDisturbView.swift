//
//  DoNotDisturbView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 25/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct DoNotDisturbView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 48)
            Text("Do not disturb mode is on")
                .fontWeight(.medium)
                .foregroundColor(.accent)
                .font(.system(size: 24))
            Spacer()
                .frame(height: 40)
            Image("doNotDisturb")
                .resizable()
                .frame(width: 150, height: 150)
            Spacer()
                .frame(height: 40)
            Text("In this mode you can’t find people, \nand are unavailable to find for others.")
                .fontWeight(.regular)
                .foregroundColor(.darkGrey)
                .font(.system(size: 14))
            Spacer()
        }
        .frame(minWidth: 0,
                maxWidth: .infinity)
        .background(Color.usersBackground)
    }
}

struct DoNotDisturbView_Previews: PreviewProvider {
    static var previews: some View {
        DoNotDisturbView()
    }
}
