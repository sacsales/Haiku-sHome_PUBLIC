//
//  MainPetView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 08/08/2023.
//

import SwiftUI
import Firebase

struct MainPetView: View {
    
    @ObservedObject var userManager: UserManager
    @ObservedObject var petManager: PetManager
    @State var showSheet = false
    @State var showConfirmAlert = false
    @State var showLiked = false
    
    
    var body: some View {
        NavigationStack {
            
                List {
                    ForEach(petManager.petsFiltered, id: \.self) { $pet in
                        PetRowView(pet: $pet)
                    }

                }
                .searchable(text: $petManager.searchTerm)

            
                .navigationTitle("Pets")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                       
//                        Button {
//                            showLiked.toggle()
//                        } label: {
//                            Image(systemName: showLiked ? "heart.fill" : "heart")
//                        }
                        
//                        Button {
//                            showConfirmAlert = true
//                        } label: {
//                            Image(systemName: "list.bullet.clipboard.fill")
//                        }
                        
                        Button {
                            showSheet = true
                        } label : {
                            Image(systemName: "plus")
                        }
                        
                        
                    }
                }
        }
        
        
        .sheet(isPresented: $showSheet) {
            NewPetView(userManager: userManager, petManager: petManager, sourceArray: $petManager.pets)
        }
    
        .alert("Load sample data? Warning: This cannot be undone!", isPresented: $showConfirmAlert) {
            Button("Replace", role: .destructive) {
                petManager.loadSampleData()
            }
        }
        
      
    }
    
    
}

struct MainPetView_Previews: PreviewProvider {
    static var previews: some View {
        MainPetView(userManager: UserManager(), petManager: PetManager())
    }
}
