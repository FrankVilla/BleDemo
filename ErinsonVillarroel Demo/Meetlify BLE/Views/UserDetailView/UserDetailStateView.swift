//
//  UserDetailStateView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 17/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct UserDetailStateView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private var user : User
    
    init(_ user: User) {
        self.user = user
    }
    
    var body: some View {
        switch user.classifier {
        case .doNotDisturb:
            Image(user.classifier.rawValue + " big")
                .foregroundColor(Color.darkGrey)
            Text(user.classifier.rawValue.uppercased())
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(Color.mediumGrey)
                .padding()
            Spacer()
            Text("\(user.name) has „do not disturb” mode on")
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundColor(Color.mediumGrey)
            Spacer()
            Button(action: close) {
                Text("Close")
                    .fontWeight(.medium)
                    .font(.system(size: 17))
                    .padding()
                    .foregroundColor(Color.black)
                    .frame(width: 295.0)
                    .background(Color("grey"))
                    .cornerRadius(10)
            }
            Spacer()
                .frame(height: 48.0);
        case .temporarilyUnavailable:
            Image(user.classifier.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.darkGrey)
            Text(user.classifier.rawValue.uppercased())
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(Color.mediumGrey)
                .padding()
            Spacer()
            Button(action: close) {
                Text("Close")
                    .fontWeight(.medium)
                    .font(.system(size: 17))
                    .padding()
                    .foregroundColor(Color.black)
                    .frame(width: 295.0)
                    .background(Color("grey"))
                    .cornerRadius(10)
            }
            Spacer()
                .frame(height: 48.0);
        default:
            Image(user.classifier.rawValue + " Big")
                .resizable()
                .frame(width: 220, height: 220)
                .padding(.horizontal, 78.0)
                .overlay(ZStack {
                    Text(user.classifier.rawValue.uppercased())
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color.accent)
                        .shadow(color: Color.accent.opacity(0.5), radius: 20, x: 0, y: 0)
                }
                .padding(.horizontal, 40.0) , alignment: .leading)
            Spacer()
            Button(action: locateUser) {
                Text("Locate")
                    .fontWeight(.medium)
                    .font(.system(size: 17))
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: 295.0)
                    .background(Color.darkGrey)
                    .cornerRadius(10)
            }
            Spacer()
                .frame(height: 48.0);
        }
    }
    
    func locateUser() -> Void {
        print("Locate \(user.name)")
    }
    
    func close() -> Void {
        presentationMode.wrappedValue.dismiss()
    }
}
#if DEBUG
struct UserDetailStateView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailStateView(User(id: "2", name: "Marek", pictureUrl: "", linkedInUrl: "", doNotDisturb: false))
    }
}
#endif
