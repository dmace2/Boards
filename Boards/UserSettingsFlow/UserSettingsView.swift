//
//  UserSettingsView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import SwiftUI

struct UserSettingsView: View {
    @State var textNameField: String = ""
    @State private var bgColor = Color(.sRGB, red: 1, green: 1, blue: 1)
    @State private var showingAlert = false
    @State private var alertText = ""
    
    @ObservedObject private var viewModel = SettingsViewModel()
    @EnvironmentObject var loginViewModel: LoginModel
    
    var body: some View {
        VStack {
            List {
                Section {
                    HStack() {
                        Spacer()
                        Image(systemName: "person.circle")
                            .resizable().scaledToFit()
                            .padding()
                            .frame(width: 200)
                        Spacer()
                    }
                }
                Section(header: Text("User")) {
                    
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("User Name:", text: $viewModel.user.name, onCommit: {
                            self.viewModel.updateUserInfo()
                        })
                            .padding()
                            .cornerRadius(5)
                            .multilineTextAlignment(.trailing)
                    }
                    VStack(alignment:.leading) {
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(viewModel.user.email)
                                .padding()
                                .cornerRadius(5)
                                .multilineTextAlignment(.trailing)
                        }
                        Text("We apologize but editing your account email address is currently unavailable in this version of the app.").font(.caption)
                            .lineLimit(nil)
                            .frame(maxHeight: .infinity)
                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                    }
                    
                }
                .onAppear {
                    self.viewModel.fetchUserData()
                }
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!)
                    }
                }
            }
            
            Spacer()
            Button("Sign Out") {
                loginViewModel.signOut()
            }
            .buttonStyle(NormalButtonStyle())
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error Signing Out"), message: Text(alertText))
            }
        }
        .navigationTitle("Settings")
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView()
    }
}
