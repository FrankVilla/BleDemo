//
//  SettingsView.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 20/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedConfig = 2
    
    var configs = [
        DistanceEvaluatorConfiguration.RAW.rawValue,
        DistanceEvaluatorConfiguration.ML_STANDARD.rawValue,
        DistanceEvaluatorConfiguration.ML_NEW.rawValue
    ]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .gray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        loadEvaluatorConfig()
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Color.darkGrey.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Settings")
                    .font(.system(size: 28))
                    .foregroundColor(Color.white)
                    .padding()
                VStack {
                    Spacer().frame(height: 48)
                    Text("Distance evaluator configuration")
                        .foregroundColor(Color.black)
                    Picker(selection: $selectedConfig.onChange(updateUserDefaults), label: Text("")) {
                        ForEach(0 ..< self.configs.count) { i in
                            Text("\(self.configs[i])").tag(i)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    Spacer()
                    Button(action: close, label: {
                        Text("Save")
                            .fontWeight(.medium)
                            .font(.system(size: 17))
                            .padding()
                            .foregroundColor(Color.white)
                            .frame(width: 295.0)
                            .background(Color.darkGrey)
                            .cornerRadius(10)
                    })
                    Spacer().frame(height: 48)
                }
                .background(Color.usersBackground)
            }
            .background(Color.darkGrey)
        }.onAppear() {
            loadEvaluatorConfig()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)        
    }
    
    func updateUserDefaults(_ newValue: Int) {
        let defaults = UserDefaults.standard
        defaults.set(configs[newValue], forKey: AppDelegate.EVALUATOR_CONFIG)
    }
    
    func loadEvaluatorConfig() {
        let defaults = UserDefaults.standard
        let userConfig = defaults.string(forKey: AppDelegate.EVALUATOR_CONFIG)
        let index = configs.firstIndex {
            $0 == userConfig
        }
        selectedConfig = index ?? 0
    }
    
    func close() -> Void {
        presentationMode.wrappedValue.dismiss()
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
