//
//  SignInWithAppleView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//
import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices

struct CustomSignInWithAppleButton: View {
    @State var currentNonce:String?
    @EnvironmentObject var loginModel: LoginModel
    var errorHandle: (Error?) -> Void
    @Environment(\.colorScheme) var colorScheme
    
    //Hashing function using CryptoKit
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    init(_ errorHandle: @escaping (Error?) -> Void) {
        self.errorHandle = errorHandle
    }
    
    var body: some View {
        SignInWithAppleButton(
            //Request
            onRequest: { request in
                let nonce = randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = sha256(nonce)
            },
            
            //Completion
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        
                        guard let nonce = currentNonce else {
                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                        }
                        guard let appleIDToken = appleIDCredential.identityToken else {
                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                        }
                        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                            return
                        }
                        
                        let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                        
                        var name: String? 
                        if appleIDCredential.fullName?.givenName != nil && appleIDCredential.fullName?.familyName != nil {
                            name = "\(appleIDCredential.fullName!.givenName!) \(appleIDCredential.fullName!.familyName!)"
                        }
                        loginModel.signIn(with: credential, name: name, completion: errorHandle)
                    default:
                        break
                        
                    }
                default:
                    break
                }
                
            }
        )
        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
        .frame(width: 200, height: 50)
    }
    
}


struct SignInWithAppleView: View {
    @EnvironmentObject var loginModel: LoginModel
    var errorHandle: (Error?) -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if colorScheme == .light {
            CustomSignInWithAppleButton(errorHandle)
                .signInWithAppleButtonStyle(.black)
        } else {
            CustomSignInWithAppleButton(errorHandle)
                .signInWithAppleButtonStyle(.white)
        }
    }
}
