//
//  PetRowView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 07/08/2023.
//

import SwiftUI

struct PetRowView: View {
    
    @Binding var pet: Pet
    
    var body: some View {
        NavigationLink {
            PetDetailView(pet: $pet)
        } label: {
            HStack {
                if pet.image == nil {
                    Circle()
                        .fill(.gray)
                        .frame(width: 80, height: 80)
                   
                } else {
                    FirebaseImageView(imagePath: pet.image!, frameSize: 100)
                        .frame(width: 80, height: 80)
                }
                
                VStack (alignment: .leading){
                    Text("\(pet.name)")
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("\(pet.location)")
                        
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                    
                }
                
            }
            
        }
    }
}


 struct PetRowView_Previews: PreviewProvider {
 static var previews: some View {
     List {
         PetRowView(pet: .constant( Pet(species: .cat, name: "Tom", age: .adult, desc: "Large ginger and white Arabian Mau.", personality: "Very affectionate and sweet. A very chill cat.", notes: "Does well with children, but may need to be an only cat.", location: "Al Maryah", userID: "dsffdsfdfdff", contact: "contact")))
         
         PetRowView(pet: .constant( Pet(species: .cat, name: "Tom", age: .adult, desc: "Large ginger and white Arabian Mau.", personality: "Very affectionate and sweet. A very chill cat.", notes: "Does well with children, but may need to be an only cat.", location: "Al Maryah", userID: "dsffdsfdfdff", contact: "contact")))
         
     }
 }
 }
 
 
