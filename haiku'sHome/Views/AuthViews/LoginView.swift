//
//  LoginView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 18/08/2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @Binding var currentShowingView: String
    
    @State private var email = ""
    @State private var password = ""
    @AppStorage("uid") var userID: String = ""
    @State private var showingAlert = false
    
    @State private var alertMessage = ""
    
    var body: some View {
        
        ScrollView {
            Image("logo")
                .resizable()
                .padding()
                .frame(width: 200, height: 200)
            Text("Log-in")
                .bold()
                .font(.largeTitle)
            TextField("Email", text: $email, axis: .vertical)
                .padding(.bottom)
                .textInputAutocapitalization(.never)
            
                
            SecureField("Password", text: $password)
                .padding(.bottom)
            
            Button {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error as? NSError {
                        
                            switch error.code {
                            case AuthErrorCode.wrongPassword.rawValue:
                                alertMessage = "Incorrect password"
                            case AuthErrorCode.invalidEmail.rawValue:
                                alertMessage = "Invalid email"
                            case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                                alertMessage = "The account already exists"
                            default:
                                alertMessage = "Unknown error: \(error.localizedDescription)"
                            }
                            showingAlert = true
                        }
                        
                    
                    if let authResult = authResult {
                        print(authResult.user.uid)
                        withAnimation {
                            userID = authResult.user.uid
                        }
                    }
                    
                    
                }
            } label: {
                Text("Let's go!")
                    .padding()
                    .background(.teal)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .bold()
            }
            
            Button {
                
                withAnimation {
                    currentShowingView = "signup"
                }
            } label: {
                Text("Don't have an account yet? Sign up here")
                    .padding()
            }
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Authentication Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        
        .padding(25)
        .textFieldStyle(.roundedBorder)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentShowingView: .constant("login"))
    }
}
