//
//  ErrorView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 20/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    
    private var callback: (() -> Void)? = nil
    
    init(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image("error")
                .resizable()
                .frame(width: 120, height: 120)
            Text("Oops!\nSomething went wrong")
                .fontWeight(.medium)
                .font(.system(size: 16))
                .padding()
                .foregroundColor(Color.darkGrey)
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: callback!) {
                Text("TRY AGAIN")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: 246.0, height: 40)
                    .background(Color.darkGrey)
                    .cornerRadius(50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.darkGrey, lineWidth: 1)
                    )
            }.padding(.bottom, 16)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(callback: {})
    }
}
#endif
