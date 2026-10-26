//
//  AuthView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 23/08/2023.
//

import SwiftUI

struct AuthView: View {
    
    @State private var currentViewShowing: String = "login"
    @ObservedObject var userManager: UserManager
    
    var body: some View {
        if currentViewShowing == "login" {
            LoginView(currentShowingView: $currentViewShowing)
        } else {
            SignUpView(userManager: userManager, currentShowingView: $currentViewShowing)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(userManager: UserManager())
    }
}
