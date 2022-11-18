//
//  PeopleView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 13/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var userDataHolder : UserDataHolder
    @ObservedObject var usersViewModel = UsersViewModel()
    private let viewTitle = "People near you"
    
    init() {
        let color = UIColor(named: "usersBackground");
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        UITableViewCell.appearance().backgroundColor = color
        UITableView.appearance().backgroundColor = color
        UITableViewHeaderFooterView.appearance().tintColor = color
    }
    
    var body: some View {
        if (usersViewModel.showLoader) {
            LoaderView()
        } else {
            ZStack {
                Color.darkGrey.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text(viewTitle)
                        .font(.system(size: 28))
                        .foregroundColor(Color.white)
                        .padding()
                    if(userDataHolder.user.doNotDisturb) {
                        DoNotDisturbView()
                    } else {
                        if (usersViewModel.error == nil) {
                            if #available(iOS 14.0, *) {
                                ScrollView {
                                    LazyVStack(spacing: 4) {
                                        Section(header: ListHeaderView("Very close")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .veryClose) {
                                                    NavigationLink(destination:  UserDetailView(user: user)) {
                                                        UserRowView(user: user)
                                                    }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                }
                                            }
                                        }.background(Color.usersBackground).animation(.easeInOut)
                                        Section(header: ListHeaderView("Close")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .close) {
                                                    NavigationLink(destination:  UserDetailView(user: user)) {
                                                        UserRowView(user: user)
                                                    }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                }
                                            }
                                        }.background(Color.usersBackground).animation(.easeInOut)
                                        Section(header: ListHeaderView("Nearby")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .nearby) {
                                                    NavigationLink(destination:  UserDetailView(user: user)) {
                                                        UserRowView(user: user)
                                                    }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                }
                                            }
                                        }.background(Color.usersBackground).animation(.easeInOut)
                                        Section(header: ListHeaderView("A bit further")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .aBitFurther) {
                                                    NavigationLink(destination:  UserDetailView(user: user)) {
                                                        UserRowView(user: user)
                                                    }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                }
                                            }
                                        }.background(Color.usersBackground).animation(.easeInOut)
                                        Section(header: ListHeaderView("Do not disturb")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .doNotDisturb) {
                                                    NavigationLink(destination:  UserDetailView(user: user)) {
                                                        UserRowView(user: user)
                                                    }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                }
                                            }
                                        }.background(Color.usersBackground).animation(.easeInOut)
                                        Section(header: ListHeaderView("Temporarily unavailable")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .temporarilyUnavailable) {
                                                    NavigationLink(destination:  UserDetailView(user: user)) {
                                                        UserRowView(user: user)
                                                    }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                }
                                            }
                                        }.background(Color.usersBackground).animation(.easeInOut)
                                    }.padding(.horizontal, 8)
                                }.background(Color.usersBackground)
                            } else {
                                List {
                                        Section(header: ListHeaderView("Very close")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .veryClose) {
                                                    ZStack {
                                                        UserRowView(user: user)
                                                        NavigationLink(destination:  UserDetailView(user: user)) {
                                                            EmptyView()
                                                        }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                    }
                                                }
                                            }.listRowBackground(Color.usersBackground)
                                        }
                                        Section(header: ListHeaderView("Close")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .close) {
                                                    ZStack {
                                                        UserRowView(user: user)
                                                        NavigationLink(destination:  UserDetailView(user: user)) {
                                                            EmptyView()
                                                        }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                    }
                                                }
                                            }.listRowBackground(Color.usersBackground)
                                        }
                                        Section(header: ListHeaderView("Nearby")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .nearby) {
                                                    ZStack {
                                                        UserRowView(user: user)
                                                        NavigationLink(destination:  UserDetailView(user: user)) {
                                                            EmptyView()
                                                        }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                    }
                                                }
                                            }.listRowBackground(Color.usersBackground)
                                        }
                                        Section(header: ListHeaderView("A bit further")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .aBitFurther) {
                                                    ZStack {
                                                        UserRowView(user: user)
                                                        NavigationLink(destination:  UserDetailView(user: user)) {
                                                            EmptyView()
                                                        }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                    }
                                                }
                                            }.listRowBackground(Color.usersBackground)
                                        }
                                        Section(header: ListHeaderView("Do not disturb")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .doNotDisturb) {
                                                    ZStack {
                                                        UserRowView(user: user)
                                                        NavigationLink(destination:  UserDetailView(user: user)) {
                                                            EmptyView()
                                                        }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                    }
                                                }
                                            }.listRowBackground(Color.usersBackground)
                                        }
                                        Section(header: ListHeaderView("Temporarily unavailable")) {
                                            ForEach(usersViewModel.users) { user in
                                                if(user.classifier == .temporarilyUnavailable) {
                                                    ZStack {
                                                        UserRowView(user: user)
                                                        NavigationLink(destination:  UserDetailView(user: user)) {
                                                            EmptyView()
                                                        }.buttonStyle(PlainButtonStyle()).background(Color.usersBackground)
                                                    }
                                                }
                                            }.listRowBackground(Color.usersBackground)
                                        }
                                }
                                .listRowInsets(EdgeInsets())
                                .background(Color.usersBackground).listStyle(PlainListStyle())
                                .frame(minWidth: 0,
                                        maxWidth: .infinity,
                                        minHeight: 0,
                                        maxHeight: .infinity,
                                        alignment: .center
                                )
                            }
                        } else {
                            ErrorView(callback: usersViewModel.load)
                        }
                    }
                }
                
            }
            .background(Color.usersBackground)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}
#if DEBUG
struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
#endif
