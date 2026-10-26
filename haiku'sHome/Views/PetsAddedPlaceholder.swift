//
//  PetsAddedPlaceholder.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 15/09/2023.
//

import SwiftUI

struct PetsAddedPlaceholder: View {
    
    @AppStorage("uid") var userID: String = ""
    @ObservedObject var petManager: PetManager
    
    var body: some View {
        
        VStack {
//            Text("Pets Added")
//            Text("user id: \(userID)")
//            Text("\(petManager.petsAdded.count)")
            
            NavigationStack {
                
                if petManager.petsAdded.isEmpty {
                    VStack {
                        Text("No pets to show...")
                        Button {
                            petManager.fetchPetsAdded(userID: userID)
                            print("refreshed")
                        } label: {
                            Text("Refresh")
                        }
                    }  .navigationTitle("Pets Added")
                    
                } else {
                    List {
                        ForEach($petManager.petsAdded, id: \.self) { $pet in
                            PetRowView(pet: $pet)
                        }
                        
                        Section {
                            Button {
                                petManager.fetchPetsAdded(userID: userID)
                                print("refreshed")
                            } label: {
                                Text("Refresh")
                            }
                        }
                        
                    }
                    .navigationTitle("Pets Added")
                }
                
                
                
            }
            
           
            
        } .onAppear {
            petManager.userID = userID
            petManager.fetchPetsAdded(userID: userID)
            
        }
        
    }
}

struct PetsAddedPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        PetsAddedPlaceholder(petManager: PetManager())
    }
}
