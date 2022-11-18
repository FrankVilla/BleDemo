//
//  ProfileView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 15/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import SwiftUI
import PartialSheet

struct ProfileView: View {
    @EnvironmentObject var userDataHolder : UserDataHolder
    @ObservedObject private var photoDownloader = PhotoDownloader()
    @State private var doNotDisturb : Bool = false
    @State private var doNotDisturbAlert : Bool = false
    @State private var canLogout : Bool = false
    
    private let viewTitle = "Me"
    private let defaults = UserDefaults.standard
    private var myId : String?
    
    init() {
        myId = defaults.string(forKey: AppDelegate.USER_ID)
        photoDownloader.load(id: myId!)
        UISwitch.appearance().onTintColor = UIColor(named: "accent")
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.darkGrey.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                HStack {
                    Text(viewTitle)
                        .font(.system(size: 28))
                        .foregroundColor(Color.white)
                        .padding()
                    Spacer()
                    NavigationLink(destination: SettingsView()) {
                        Image("settings").foregroundColor(.white)
                    }.padding()
                }
                VStack(alignment: .center) {
                    VStack {
                        Image(uiImage: photoDownloader.photo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.accent)
                            .frame(width: 96, height: 96)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.accent, lineWidth: 1));
                        Spacer()
                            .frame(height: 19.0);
                        if (userDataHolder.user.linkedInUrl != nil) {
                            Image("linkedInLogo")
                                .resizable()
                                .foregroundColor(Color.accent)
                                .frame(width: 28, height: 28)
                                .onTapGesture {
                                    if let link = URL(string: userDataHolder.user.linkedInUrl!) {
                                      UIApplication.shared.open(link)
                                    }
                                }
                            Spacer()
                                .frame(height: 25.0);
                        }
                        Text(userDataHolder.user.name)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer()
                            .frame(height: 73.0);
                        HStack {
                            Text("Do not disturb")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color.accent)
                            if #available(iOS 14.0, *) {
                                Toggle("Do not disturb", isOn: $userDataHolder.user.doNotDisturb)
                                    .labelsHidden()
                                    .padding()
                                    .alert(isPresented:$doNotDisturbAlert) {
                                        Alert(title: Text("Do not disturb mode"), message: Text("Others will not be able to find you while you are in „Do not disturb” mode"), dismissButton: .default(Text("Ok")))
                                    }
                                    .toggleStyle(SwitchToggleStyle(tint: .accent))
                                    .onReceive([userDataHolder.user.doNotDisturb].publisher.first()) { (value) in
                                        doNotDisturbAlert = value
                                        updateDoNotDisturbMode(doNotDisturb: value)
                                        
                                    }
                            } else {
                                Toggle("Do not disturb", isOn: $userDataHolder.user.doNotDisturb)
                                    .labelsHidden()
                                    .padding()
                                    .alert(isPresented:$doNotDisturbAlert) {
                                        Alert(title: Text("Do not disturb mode"), message: Text("Others will not be able to find you while you are in „Do not disturb” mode"), dismissButton: .default(Text("Ok")))
                                    }
                                    .onReceive([userDataHolder.user.doNotDisturb].publisher.first()) { (value) in
                                        doNotDisturbAlert = value
                                        updateDoNotDisturbMode(doNotDisturb: value)
                                        
                                    }
                            }
                        }
                        
                        Spacer().frame(height: 25.0)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(Color.darkGrey)
                    Spacer()
                    NavigationLink(destination:  LoginView().environmentObject(PartialSheetManager()), isActive: $canLogout) {
                        Button(action: logout) {
                            Text("LOGOUT")
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
                        }
                    }
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                .background(Color.usersBackground)
                .edgesIgnoringSafeArea(.all)
            }
            
        }
        .background(Color.usersBackground)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    func updateDoNotDisturbMode(doNotDisturb: Bool) {
        if(doNotDisturb != self.doNotDisturb) {
            ApiLayerController.shared.userService.changdeDoNotDisturbMode(id: myId!, doNotDisturb: doNotDisturb) { response in
                doNotDisturbAlert = false
                self.doNotDisturb = response!
                userDataHolder.user.doNotDisturb = response!
                try? userDataHolder.save()
                if (userDataHolder.user.doNotDisturb) {
                    Advertiser.shared.stopAdvertising()
                    Scanner.shared.stopScanning()
                } else {
                    Advertiser.shared.startAdvertising()
                    Scanner.shared.startScanning()
                }
            }
        }
        
    }
    
    func logout() -> Void {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: AppDelegate.USER_ID)
        defaults.removeObject(forKey: AppDelegate.USER)
        Scanner.shared.stopScanning()
        Advertiser.shared.stopAdvertising()
        self.canLogout = true
    }
    
    func reload() -> Void {
        photoDownloader.load(id: myId!)
    }
}
#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
#endif
