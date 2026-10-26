//
//  PetDetailView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 07/08/2023.
//

//date of birth approx.
//gender
//neutered/spayed, vaccinated, microchipped (toggles)
//date added
//indoor, indoor and outdoor (picker)
//younger/older children
//special needs/toggle + notes 

import SwiftUI
import FirebaseStorage

struct PetDetailView: View {
    
    @Binding var pet: Pet
    @State var showSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                
                HStack {
                    
                        
                    if pet.image != nil {
                        
                        FirebaseImageView(imagePath: pet.image!, frameSize: 200)
                            .frame(width: 150, height: 150)
                      
                            .onTapGesture {
                                showSheet = true
                            }
                    }
                        

                    
                    
                    VStack (alignment: .leading) {
                        TagView(tagText: pet.species.stringValue(), color: .orange)
                        TagView(tagText: pet.age.stringValue(), color: .green)
                        
                        if pet.social == true {
                            TagView(tagText: "Social", color: .blue)
                        }
                        
                        if pet.kidFriendly == true {
                            TagView(tagText: "Kid-friendly", color: .indigo)
                        }
                       
                    }
                    
                    
                }
                .listRowSeparator(.hidden)
                
                Section {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("\(pet.location)")
                        
                    }
                }
                .font(.footnote)
                
                
                .listRowSeparator(.hidden)
                Section ("Description"){
                    Text("\(pet.desc)")
                }
                .listRowSeparator(.hidden)
                Section ("Personality"){
                    Text("\(pet.personality)")
                }
                .listRowSeparator(.hidden)
                Section ("Notes"){
                    Text("\(pet.notes)")
                }
                
                .listRowSeparator(.hidden)
                Section {
                    Text("\(pet.contact)")
                        .textSelection(.enabled)
                } header: {
                    Text("Contact")
                } footer: {
                    Text("Interested in adopting \(pet.name)? Contact their rescuer with their email above.")
                    
                }
                
//                .listRowSeparator(.hidden)
//                Section ("User Added"){
//                    Text("\(pet.userID)")
//
//                }
                
//                Section ("Actions") {
//                    Button {
//                        pet.isSaved.toggle()
//
//                    } label: {
//                        Text("Contact \(pet.name)'s rescuer")
//                    }
//                }
                
            }
            .sheet(isPresented: $showSheet) {
                FirebaseImageView(imagePath: pet.image!, frameSize: 300)
                    //.frame(width: 150, height: 150)
            }
            .listStyle(.insetGrouped)
            .navigationTitle(pet.name)
            .onAppear {
                print($pet.social)
                
                //print(pet.image!)
            }
        }
    }
}

/*
struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PetDetailView(pet: .constant( Pet(species: .cat, name: "Tom", age: .adult, desc: "Large ginger and white Arabian Mau.", personality: "Very affectionate and sweet. A very chill cat.", notes: "Does well with children, but may need to be an only cat.", kidFriendly: true, social: true, location: "Al Maryah", isSaved: false)))
    }
}
*/
