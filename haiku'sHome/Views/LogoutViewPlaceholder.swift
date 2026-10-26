//
//  LogoutViewPlaceholder.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 23/08/2023.
// placeholder view for logout

import SwiftUI
import FirebaseAuth


struct LogoutViewPlaceholder: View {
    
    @AppStorage("uid") var userID: String = ""
    @ObservedObject var userManager: UserManager
    
    var body: some View {
        
        VStack {
            
            if let user = userManager.user {
                Text("Hello, \(user.firstName)")
                
            }
            
            Text(userID)
            
            Button {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    withAnimation {
                        userID = ""
                    }
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            } label: {
                Text("Sign Out")
            }
        }
        .onAppear {
            if !userID.isEmpty {
                userManager.fetchUser(withUserID: userID)
            }
        }
    }
}

struct LogoutViewPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        LogoutViewPlaceholder(userManager: UserManager())
    }
}
