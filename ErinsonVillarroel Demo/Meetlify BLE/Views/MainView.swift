//
//  MainView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 13/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0;
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UITabBar.appearance().barTintColor = .white
    }
    
    var body: some View {
        NavigationView {
            TabView {
                UsersView()
                    .tabItem {
                        Image("TrackScan")
                            .resizable()
                            .frame(width: 22.0)
                    }
                ProfileView()
                    .tabItem {
                        Image("Identity")
                            .resizable()
                            .frame(width: 22.0, height: 15.0)
                    }
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .background(Color.white)
        .accentColor(Color.darkGrey)
    }
}
#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
