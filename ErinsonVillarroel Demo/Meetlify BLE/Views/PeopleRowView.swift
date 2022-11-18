//
//  PeopleRowView.swift
//  Meetlify BLE
//
//  Created by Szymon Majchrzyk on 13/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct UserRowView: View {
    
    var user: User
    
    
    var body: some View {
        HStack {
            Image("user").foregroundColor(Color("tea500"))
            Spacer()
            Text($name)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(.white)
            Spacer()
            VStack (spacing: 0.0) {
                Text($distance)
                    .font(.system(size: 14))
                    .foregroundColor(Color("tea500"))
                    .fontWeight(.medium)
                Image("distance")
                    .resizable()
                    .foregroundColor(Color("tea500"))
                    .frame(width: 36.0, height: 20.0)
            }
            .padding(4)
            .background(Color("taupe700"))
            .cornerRadius(50)
        }
        .padding(.leading, 28)
        .padding(.trailing, 28)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}

struct PeopleRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView()
    }
}
