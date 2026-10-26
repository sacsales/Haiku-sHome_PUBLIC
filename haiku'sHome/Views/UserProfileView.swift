//
//  UserProfileView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 16/09/2023.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    
    @AppStorage("uid") var userID: String = ""
    @ObservedObject var userManager: UserManager
    @ObservedObject var petManager: PetManager
    
    @State var showConfirmAlert = false
    @State var showDeleteConfirmation = false
    
    @State var showSheet = false
    
    var body: some View {
        
        let user = Auth.auth().currentUser
        
        NavigationStack {
            VStack {
                
                List {
                    Section ("Name") {
                        if let user = userManager.user {
                            Text("\(user.firstName) \(user.lastName)")
                        }
                    }
                    
                    Section ("ID") {
                        Text(userID)
                    }
                   
                    
                    if let user = user {
                        Section ("Contact") {
                            Text("\(user.email!)")
                        }
                    }
                    if petManager.petsAdded.count != 0 {
                        Section ("Pets Added") {
                            ForEach($petManager.petsAdded, id: \.self) { $pet in
                                PetRowView(pet: $pet)
                            }
                        }
                    }
                    
                    NavigationLink {
                        FAQView()
                    } label: {
                        Text("Helpful Resources")
                    }
                    Section ("Actions"){
                       
                        Button {
                            showConfirmAlert = true
                        } label: {
                            Text("Sign Out")
                        }
                        Button (role: .destructive) {
                            showDeleteConfirmation = true
                        } label: {
                            Text("Delete Account")
                        }
                    }
                    
                }
                .navigationTitle("Profile")
                
            }
            
            
            
        } .onAppear {
            if !userID.isEmpty {
                userManager.fetchUser(withUserID: userID)
            }
            
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $showSheet) {
            FAQView()
        }
        
        .alert("Are you sure you want to sign out?", isPresented: $showConfirmAlert) {
        
            Button ("Sign Out" ){
                userID = userManager.signOut(userID: userID)
            }
        }
        
        .alert("Are you sure? Your account, along with any pet profiles you have uploaded will be deleted permanently.", isPresented: $showDeleteConfirmation) {
            
            Button ("Delete my account", role: .destructive){
                
                petManager.fetchPetsAdded(userID: userID)
                petManager.deleteAllUserPets(userID: userID)
                userManager.deleteAccount(userID: userID)
                userID = userManager.signOut(userID: userID)
                
               
            }
        }
        
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userManager: UserManager(), petManager: PetManager())
    }
}
