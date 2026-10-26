//
//  ContentView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 16/07/2023.

// 

import SwiftUI

struct ContentView: View {
    
    @StateObject private var petManager = PetManager()
    @StateObject private var userManager = UserManager()
    
    @AppStorage("uid") var userID: String = ""
    
    
    var body: some View {
        
        if userID == "" {
            AuthView(userManager: userManager)
        } else {
            TabView {
                MainPetView(userManager: userManager, petManager: petManager)
                    .tabItem {
                        Label("Pets", systemImage: "pawprint.fill")
                    }
//                LogoutViewPlaceholder(userManager: UserManager())
//                    .tabItem {
//                        Label("Profile", systemImage: "arrow.right")
//                    }
//                PetsAddedPlaceholder(petManager: PetManager())
//                    .tabItem {
//                        Label("Pets Added", systemImage: "pawprint")
//                    }
                
                UserProfileView(userManager: userManager, petManager: petManager)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                
            } .onAppear {
                petManager.getData()
                petManager.userID = userID
                petManager.fetchPetsAdded(userID: userID)
            }
            
        }
        
    }
    
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
