//
//  PeopleRowView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 13/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct UserRowView: View {
    
    var user: User;
    @ObservedObject private var photoDownloader = PhotoDownloader()
    
    init (user: User) {
        self.user = user
        photoDownloader.load(id: user.id)
    }
    
    
    var body: some View {
        HStack {
            Image(uiImage: photoDownloader.photo)
                .resizable()
                .frame(width: 48, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.accent)
//                .transition(.opacity)
//                .animation(.easeInOut(duration: 1))
                .clipShape(Circle())
            Spacer().frame(width: 16)
            Text(user.name)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color.darkGrey)
            Spacer()
            if (user.linkedInUrl != nil){
                Image("linkedInLogo")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.mediumGrey)
                    .onTapGesture {
                    if let link = URL(string: user.linkedInUrl!) {
                      UIApplication.shared.open(link)
                    }
                }
                Spacer().frame(width: 16)
            }
        
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        
    }
}
#if DEBUG
struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(id: "1", name: "Janek", pictureUrl: "", linkedInUrl: "", doNotDisturb: false))
    }
}
#endif
