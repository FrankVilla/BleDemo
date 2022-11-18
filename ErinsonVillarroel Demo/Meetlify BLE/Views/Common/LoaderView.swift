//
//  LoaderView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 21/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct LoaderView: View {
    
    @State private var wave_1 = false
    @State private var wave_2 = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .stroke(lineWidth: 2.0)
                    .frame(width: 96, height: 96)
                    .foregroundColor(Color.darkGrey.opacity(0.6))
                    .scaleEffect(wave_1 ? 2 : 1)
                    .opacity(wave_1 ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false).speed(1))
                    .onAppear() {
                        self.wave_1.toggle()
                    }
                Circle()
                    .stroke(RadialGradient(gradient: Gradient(colors: [Color.darkGrey.opacity(0.6), Color.accent]), center: .center, startRadius: 5, endRadius: 80), lineWidth: 2.0)
                    .frame(width: 96, height: 96)
                    .scaleEffect(wave_2 ? 2.5 : 1)
                    .opacity(wave_2 ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false).delay(0.75).speed(1))
                    .onAppear() {
                        self.wave_2.toggle()
                    }
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.white)
                Image("Vec_SplashLogo")
                    .resizable()
                    .foregroundColor(Color.darkGrey)
                    .frame(width: 76.0, height: 60.0)
            }
            Spacer().frame(height: 80.0)
            Text("Meetlify is searching...").foregroundColor(Color.darkGrey)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
#if DEBUG
struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
#endif
