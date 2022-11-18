//
//  ContentView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 11/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI
import PartialSheet

struct LoginView: View {
    
    @EnvironmentObject var partialSheet : PartialSheetManager
    @ObservedObject var name = TextFieldChanges()
    @ObservedObject var linkedInUrlTextField = TextFieldChanges()
    @State private var isActive: Bool = false
    @State private var showLinkedInBottomSheet = false
    @State private var linkedInUrl : String = ""
    @State private var error : Bool = false
    @State private var alertTitle = ""
    @State private var alertContent = ""
    private var userDataHolder : UserDataHolder = UserDataHolder()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                Spacer().frame(height: 24.0)
                    Image("Vec_SplashLogo")
                        .resizable()
                        .foregroundColor(Color.black.opacity(0.3))
                        .frame(width: 54.0, height: 38.0);
                    Spacer()
                        .frame(height: 32.0);
                    Image("user")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("accent"))
                        .frame(width: 70, height: 70)
                        .padding(45)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color("accent"), style: StrokeStyle(lineWidth: 2, dash: [5])));
                    Spacer()
                        .frame(height: 44.0);
                TextField("Name", text: $name.text)
                    .placeHolder(Text("Name").foregroundColor(Color("grey")), show: name.text.isEmpty)
                    .padding(16.0)
                    .foregroundColor(Color("grey"))
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius:10).stroke(Color("grey"), lineWidth: 1))
                    Spacer()
                        .frame(height: 54.0)
                if(name.text.isEmpty && linkedInUrl.isEmpty) {
                    greetingView
                } else if (!name.text.isEmpty && linkedInUrl.isEmpty) {
                    addLinkedInProvileView
                } else {
                    linkedInProvileSetView
                }
                NavigationLink(destination: MainView().environmentObject(userDataHolder), isActive: $isActive) {
                    Button(action: createAccount) {
                        Text("CREATE ACCOUNT")
                            .fontWeight(.medium)
                            .font(.system(size: 14))
                            .padding()
                            .foregroundColor(Color.white)
                            .frame(width: 246.0, height: 40)
                            .background(Color("darkGrey"))
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color("darkGrey"), lineWidth: 1)
                            )
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            
                    };
                }
            }
            .alert(isPresented: $error) {
                Alert(title: Text(alertTitle), message: Text(alertContent), dismissButton: .default(Text("Ok")))
            }
            .padding(.horizontal, 40)
            .frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .top
            )
            .background(SwiftUI.Color.white.edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .addPartialSheet(style: PartialSheetStyle(
                            background: .solid(Color.white),
                            handlerBarColor: .white,
                            enableCover: true,
                            coverColor: Color.black.opacity(0.6),
                            blurEffectStyle: .dark,
                            cornerRadius: 10,
                            minTopDistance: 200))
    }
    
    var greetingView : some View {
        Group {
            Text("Hi! Thanks for choosing Meetlify")
                .foregroundColor(Color("accent"))
                .font(.system(size: 18))
                .fontWeight(.medium)
            Spacer()
                .frame(height: 12.0);
            Text("Add photo and name to make \nit easier to find you")
                .foregroundColor(Color("darkGrey"))
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
            Spacer().frame(height: 62.0)
        }
    }
    
    var addLinkedInProvileView : some View {
        Group{
            HStack {
                Image("Add")
                Text("ADD LinkedIN PROFILE")
                    .foregroundColor(Color.black)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                Image("linkedInLogo").resizable().frame(width: 24, height: 24)
            }
            Spacer().frame(height: 163)
        }.onTapGesture {
            self.partialSheet.showPartialSheet({print("dismissed")}) {
                pasteLinkedInUrlView
            }
        }
    }
    
    var linkedInProvileSetView : some View {
        Group{
            HStack {
                Text("LINKEDIN PROFILE")
                    .foregroundColor(Color.black)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                Image("linkedInLogo").resizable().frame(width: 24, height: 24)
                Spacer()
                Image("Done").resizable().frame(width: 24, height: 24)
            }
            Spacer().frame(height: 163)
        }.onTapGesture {
            self.partialSheet.showPartialSheet({print("dismissed")}) {
                pasteLinkedInUrlView
            }
        }
    }
    
    var pasteLinkedInUrlView : some View {
        VStack{
            Text("Please add link to your public LinkedIn profile")
                .foregroundColor(Color.black)
                .font(.system(size: 13))
                .fontWeight(.semibold)
            Spacer().frame(height: 51.0)
            TextField("Profile Url", text: $linkedInUrlTextField.text)
                .placeHolder(Text("Profile Url").foregroundColor(Color("grey")), show: linkedInUrlTextField.text.isEmpty)
                .padding(16.0)
                .foregroundColor(Color("grey"))
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius:10).stroke(Color("grey"), lineWidth: 1))
            Spacer().frame(height: 13)
            Text("Please add link to public Linkedin profile, so others can find you easier")
                .foregroundColor(Color.black)
                .font(.system(size: 13))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 42)
            Button(action: saveUrlProfile) {
                Text("SAVE")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: 295.0, height: 50)
                    .background(Color("darkGrey"))
                    .cornerRadius(50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color("darkGrey"), lineWidth: 1)
                    )
            };
            Button(action: cancel) {
                Text("CANCEL")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .padding()
                    .foregroundColor(Color.black)
                    .frame(width: 295.0, height: 50)
                    .background(Color.clear)
                    .cornerRadius(50)
                    
            }
            Spacer().frame(height: 0)
        }.padding(.horizontal, 32)
    }
    
    func saveUrlProfile() {
        self.showLinkedInBottomSheet = false
        partialSheet.closePartialSheet()
        linkedInUrl = linkedInUrlTextField.text
    }
    
    func cancel() {
        self.showLinkedInBottomSheet = false
        partialSheet.closePartialSheet()
        linkedInUrl = ""
    }
    
    
    
    func createAccount() -> Void {
        if(self.name.text.count != 0) {
            let user = User(name: self.name.text, picture: "", linkedInUrl: linkedInUrl.isEmpty ? nil : linkedInUrl)
            ApiLayerController.shared.userService.createUser(user: user) { (error) in
                guard (error != nil) else {
                    let defaults = UserDefaults.standard
                    let myId = defaults.string(forKey: AppDelegate.USER_ID)
                    ApiLayerController.shared.userService.getUser(id: myId!) { (u, e) in
                        guard (e != nil) else {
                            userDataHolder.user = u!
                            do {
                                try userDataHolder.save()
                                self.isActive = true
                            } catch {
                                print(error)
                            }
                            
                           
                            return
                        }
                        self.alertTitle = "There was an error"
                        self.alertContent = e!.localizedDescription
                        self.error = true
                    }
                    return
                }
                self.alertTitle = "There was an error"
                self.alertContent = error!
                self.error = true
            
            }
        } else {
            self.alertTitle = "There was an error"
            self.alertContent = "Enter user name"
            self.error = true
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
