//
//  SwiftUIView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 17/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct ListHeaderView: View {
    
    private var title : String = ""
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding()
                .layoutPriority(1)
            VStack { Divider().background(Color.black) }
            Image(title).resizable().frame(width: 40.0, height: 40.0)
        }
    }
}
#if DEBUG
struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView("Very close")
    }
}
#endif
