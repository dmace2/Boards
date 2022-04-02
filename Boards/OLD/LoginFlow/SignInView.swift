//
//  LoginView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import SwiftUI

struct SignInViewOLD: View {
    @State var email = ""
    @State var password = ""
    @State var secondaryPassword = ""
    @State var firstname = ""
    @State var lastname = ""
    
    @EnvironmentObject private var viewModel: LoginModel
    
    @State var alertText = ""
    @State var showingAlert = false
    @State private var signUp = false
    
    var body: some View {
        VStack {
            Image("CrescentMoon")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
                .foregroundColor(Color(.systemBlue))
            Spacer()
            VStack {
                if signUp {
                    TextField("First Name:",text: $firstname)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(5)
                    TextField("Last Name:",text: $lastname)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(5)
                }
                TextField("Email:",text: $email)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding()
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemFill))
                    .cornerRadius(5)
                if signUp {
                    SecureField("Password:", text: $password)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(5)
                        .textContentType(.newPassword)
                    SecureField("Confirm Password:", text: $secondaryPassword)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(5)
                        .textContentType(.newPassword)
                } else {
                    SecureField("Password:", text: $password)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(5)
                        .textContentType(.password)
                }
            }
            .padding()
            Spacer()
            VStack {
                SignInWithAppleView(errorHandle: {error in
                    if let e = error {
                        alertText = e.localizedDescription
                        showingAlert = true
                    }
                })
                .buttonStyle(NormalButtonStyle())
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error Authenticating User"), message: Text(alertText))
                }
                
                
                if signUp {
                    Button(action: {
                        guard !firstname.isEmpty && !lastname.isEmpty && !email.isEmpty && !password.isEmpty && password == secondaryPassword else {
                            return
                        }
                        
                        viewModel.signUp(name: "\(firstname) \(lastname)", email: email, password: password, completion: { error in
                            if let e = error {
                                alertText = e.localizedDescription
                                showingAlert = true
                            }
                        })
                    }, label: {
                        Text("Sign Up")
                    })
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error Authenticating User"), message: Text(alertText))
                    }
                    .padding(5)
                    .buttonStyle(NormalButtonStyle())
                    
                    Button(action: {
                        withAnimation {
                            signUp = false
                        }
                    }, label: {
                        Text("Have an Account? Sign In Instead!")
                            .foregroundColor(Color(.systemBlue))
                    })
                    .navigationTitle("Sign Up")
                } else {
                    Button(action: {
                        guard !email.isEmpty && !password.isEmpty else {
                            return
                        }
                        viewModel.signIn(email: email, password: password, completion: { error in
                            if let e = error {
                                alertText = e.localizedDescription
                                showingAlert = true
                            }
                        })
                    }, label: {
                        Text("Sign In")
                    })
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error Authenticating User"), message: Text(alertText))
                    }
                    .buttonStyle(NormalButtonStyle())
                    .padding(5)
                    
                    Button(action: {
                        withAnimation {
                            signUp = true
                        }
                    }, label: {
                        Text("Need an account? Sign up here!")
                            .foregroundColor(Color(.systemBlue))
                    })
                }
            }
            .padding()
            .navigationTitle("Sign In")
        }
    }
    
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView().environmentObject(LoginModel())
//    }
//}
