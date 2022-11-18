//
//  UserDetailView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 13/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var photoDownloader = PhotoDownloader()
    var user: User
    
    init(user : User) {
        self.user = user
        photoDownloader.load(id: user.id)
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("closeBtn").onTapGesture {
                    close()
                }
                Spacer()
            }.padding(.horizontal, 16.0)
            Spacer()
                    .frame(height: 45.0)
            Image(uiImage: photoDownloader.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.accent)
                .frame(width: 96, height: 96)
                .clipShape(Circle())
                .overlay(Circle()
                            .stroke(Color.accent, lineWidth: 1));
            Spacer()
                .frame(height: 8.0);
            Text(user.name)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .foregroundColor(.black)
            if (user.linkedInUrl != nil){
                Spacer().frame(height: 28)
                Image("linkedInLogo")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color.darkGrey)
                    .onTapGesture {
                    if let link = URL(string: user.linkedInUrl!) {
                      UIApplication.shared.open(link)
                    }
                }
                Spacer()
            } else {
                Spacer()
                    .frame(height: 107.0);
            }
            UserDetailStateView(user)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
        )
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
    
    func close() -> Void {
        presentationMode.wrappedValue.dismiss()
    }
}
#if DEBUG
struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User(id: "2", name: "Marek", pictureUrl: "", linkedInUrl: "", doNotDisturb: false))
    }
}
#endif
