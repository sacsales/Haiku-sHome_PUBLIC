//
//  NewTodoView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 07/08/2023.
//

import SwiftUI
import FirebaseAuth

struct NewPetView: View {
    
    @ObservedObject var userManager: UserManager
    @ObservedObject var petManager: PetManager
    @AppStorage("uid") var userID: String = ""
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    
    @State var species: Species = .cat
    @State var name: String =  ""
    @State var age: AgeRange = .adult
    
    @State var desc: String = ""
    @State var personality: String = ""
    @State var notes: String = ""
    
    @State var location: String = ""
    @State var kidFriendly: Bool = false 
    @State var social: Bool = false
    
    @Binding var sourceArray: [Pet]
    
    @Environment(\.dismiss) var goAway
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section ("Name"){
                    TextField("Name", text: $name)
                    
                }
                
                Section ("Photos") {
                    
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .frame(width:100, height: 100)
                    } else {
                        Button {
                            isPickerShowing = true
                        } label: {
                            Text("Choose Photos")
                        }
                    }
                }
                Section ("Physical Description") {
                    TextField("E.g. Ginger Arabian Mau", text: $desc, axis: .vertical)
                }
                Section ("Personality") {
                    TextField("E.g. Very shy at first, but affectionate!", text: $personality, axis: .vertical)
                }
                Section ("Notes"){
                    TextField("E.g. Needs a large outdoor space...", text: $notes, axis: .vertical)
                }
                Section {
                    Picker("Age", selection: $age) {
                        ForEach(AgeRange.allCases, id: \.self) { age in
                            Text("\(age.stringValue())")
                        }
                    }
                    
                    Picker("Species", selection: $species) {
                        ForEach(Species.allCases, id: \.self) { species in
                            Text("\(species.stringValue())")
                        }
                    }
                }
                
                Section ("Suited to households with") {
                    Toggle("Children", isOn: $kidFriendly)
                    Toggle("Other animals", isOn: $social)
                }
                
                
                Section {
                    TextField("Location", text: $location)
                }
                
                Section {
                    Button("Save") {
                        if name.isEmpty || desc.isEmpty || notes.isEmpty || personality.isEmpty || location.isEmpty || selectedImage == nil {
                            showAlert = true
                        } else {
                            petManager.addData(species: species, name: name, age: age, desc: desc, personality: personality, notes: notes, kidFriendly: kidFriendly, social: social, location: location, userID: userID, image: selectedImage, contact: Auth.auth().currentUser!.email!)
                            petManager.getData()
                            goAway()
                            
                        }
                        
                    }
                    Button("Cancel", role: .destructive) {
                        goAway()
                    }
                }
                
                
            }
            .navigationTitle("New Pet Profile")
        }
        
        .onAppear {
            petManager.getData()
        }
        
        .alert("Please make sure all fields are filled.", isPresented: $showAlert) {
            Button {
                showAlert = false
            } label: {
                Text("Ok")
            }
        }
        
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            
        }
        
    }
}





    

struct NewPetView_Previews: PreviewProvider {
    static var previews: some View {
        NewPetView(userManager: UserManager(), petManager: PetManager(), sourceArray: .constant([]))
    }
}
