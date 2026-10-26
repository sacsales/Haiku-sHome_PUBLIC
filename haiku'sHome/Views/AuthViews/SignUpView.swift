//
//  SignUpView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 23/08/2023.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var methodOfContact = ""
    
    
    @AppStorage("uid") var userID: String = ""
    
    @ObservedObject var userManager: UserManager
    
    @Binding var currentShowingView: String
    
    var body: some View {
        
        ScrollView {
            
            Image("logo")
                .resizable()
                .padding()
                .frame(width: 200, height: 200)
            
            Text("Sign Up")
                .bold()
                .font(.largeTitle)
            
            HStack {
                TextField("First Name", text: $firstName, axis: .vertical)
                TextField("Last Name", text: $lastName, axis: .vertical)
                   
            }
            .padding(.bottom)
            
            TextField("Email", text: $email, axis: .vertical)
                .textInputAutocapitalization(.never)
            HStack {
                Image(systemName: "info.circle")
                Text("If you put an animal up for adoption, this is how potential adopters will contact you.")
                    .font(.footnote)
            }
            .foregroundColor(.gray)
            .padding(.bottom)
            SecureField("Password", text: $password)
                .padding(.bottom)
               
            
            Button {
                
                userManager.createUser(email: email, password: password, firstName: firstName , lastName: lastName) { result in
                    switch result {
                    case .success(let userID):
                        print("User created with userID: \(userID)")
                        self.userID = userID
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
                
                
            } label: {
                Text("Sign Up")
                    .padding()
                    .background(.teal)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .bold()
            }
            
            Button {
                withAnimation {
                    currentShowingView = "login"
                    
                }
            } label: {
                Text("I already have an account")
                    .padding()
            }
            
        }
        
        .padding(25)
        .textFieldStyle(.roundedBorder)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(userManager: UserManager(), currentShowingView: .constant("signin"))
    }
}
