//
//  PetManager.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 07/08/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage


class PetManager: ObservableObject {
    @Published var pets: [Pet] = [] {
        didSet {
            save()
        }
    }
    
    @Published var petsAdded: [Pet] = [] {
        didSet {
            save()
        }
    }


    
    init() {
        load()
    }
    
    func fetchPetsAdded(userID: String) {
        
        let collectionReference = db.collection("pets")

        //let userID = "sHrnwrvaimc2kScJiMCseQScHL32"

        // Query documents where "userID" field matches the specific value
        collectionReference.whereField("userID", isEqualTo: userID).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }

            self.petsAdded = []

            // Iterate through the documents and add them to the published variable
            self.petsAdded =  querySnapshot?.documents.map { d in
                print("pet found")
                return Pet(
                    id: d.documentID,
                    species: Species(rawValue: d["species"] as? String ?? "") ?? .cat,
                    name: d["name"] as? String ?? "",
                    age: AgeRange(rawValue: d["age"] as? String ?? "") ?? .adult,
                    desc: d["desc"]as? String ?? "",
                    personality: d["personality"]as? String ?? "",
                    notes: d["notes"]as? String ?? "",
                    kidFriendly: d["kidFriendly"] as? Bool ?? false,
                    social: d["social"] as? Bool ?? false,
                    location: d["location"] as? String ?? "",
                    userID: d["userID"] as? String ?? "",
                    image: d["image"] as? String ?? "",
                    contact: d["contact"] as? String ?? ""
                )
                
//                if let yourDocument = try? document.data(as: Pet.self) {
//                    self.petsAdded.append(yourDocument)
//                    print("pet added")
//                }
                
            } ?? []
        }
    }
    
    func deleteAllUserPets(userID: String) {
        for pet in self.petsAdded {
            db.collection("pets").document(pet.id).delete()
        }
    }
    
    
    
    @Published var searchTerm = ""
    @Published var userID = ""
    
    func loadSampleData() {
        // pets = Pet.samplePets
        //disabled for now!
    }
    
    
    private var db = Firestore.firestore()
    
    
    func addData(species: Species, name: String, age: AgeRange, desc: String, personality: String, notes: String, kidFriendly: Bool, social: Bool, location: String, userID: String, image: UIImage?, contact: String) {
        let db = Firestore.firestore()
        
        guard image != nil else {
            return
        }
        let storageRef = Storage.storage().reference()
        
        let imageData = image!.jpegData(compressionQuality: 0.5)
        
        guard imageData != nil else {
            return
        }
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        print(path)
        
    
        let uploadTask = fileRef.putData(imageData!, metadata: metadata) {
            metadata, error in
            
            if error == nil && metadata != nil {
                let db = Firestore.firestore()
                
                db.collection("images").document().setData(["url":path]) { error in
                    if error == nil {
//                        DispatchQueue.main.async {
//                            self.retrievedImages.append(self.selectedImage!)
//                        }
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            
            db.collection("pets").addDocument(data: [
                "name": name,
                "species": species.rawValue,
                "age": age.rawValue,
                "desc": desc,
                "personality": personality,
                "notes": notes,
                "kidFriendly": kidFriendly,
                "social": social,
                "location": location,
                "userID": userID,
                "image": path,
                "contact": contact
                
                //
            ]) { error in
                if error == nil {
                    self.getData()
                    print(path)
                }
                
                
            }
        }
        
    }
    
    
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("pets").getDocuments { snapshot, error in
            
            if error == nil {
                //cool!
                
                if let snapshot {
                    
                    DispatchQueue.main.async {
                        self.pets = snapshot.documents.map { d in
                            return Pet(
                                id: d.documentID,
                                species: Species(rawValue: d["species"] as? String ?? "") ?? .cat,
                                name: d["name"] as? String ?? "",
                                age: AgeRange(rawValue: d["age"] as? String ?? "") ?? .adult,
                                desc: d["desc"]as? String ?? "",
                                personality: d["personality"]as? String ?? "",
                                notes: d["notes"]as? String ?? "",
                                kidFriendly: d["kidFriendly"] as? Bool ?? false,
                                social: d["social"] as? Bool ?? false,
                                location: d["location"] as? String ?? "",
                                userID: d["userID"] as? String ?? "",
                                image: d["image"] as? String ?? "",
                                contact: d["contact"] as? String ?? ""
                            )
                        }
                        
                    }
                }
            }
            else {
                //oops.
            }
        }
        
        
        
    }
    
    
    var petsFiltered: Binding<[Pet]> {
        Binding (
            get: {
                if self.searchTerm == "" { return self.pets }
                return self.pets.filter {
                    $0.name.lowercased().contains(self.searchTerm.lowercased()) || $0.location.lowercased().contains(self.searchTerm.lowercased()) || $0.age.stringValue().lowercased().contains(self.searchTerm.lowercased()) ||
                    $0.species.stringValue().lowercased().contains(self.searchTerm.lowercased())
                }
            },
            set: {
                self.pets = $0
            }
        )
    }
    
    var petsLiked: Binding<[Pet]> {
        Binding (
            get: {
                if self.searchTerm == "" { return self.pets.filter { $0.isSaved }}
                return self.pets.filter {
                    $0.isSaved && $0.name.lowercased().contains(self.searchTerm.lowercased()) || $0.location.lowercased().contains(self.searchTerm.lowercased()) || $0.age.stringValue().lowercased().contains(self.searchTerm.lowercased()) ||
                    $0.species.stringValue().lowercased().contains(self.searchTerm.lowercased())
                }
            },
            set: {
                self.pets = $0
            }
        )
    }
    
    
    
    
    
    func getArchiveURL() -> URL {
        let plistName = "pets.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedPets = try? propertyListEncoder.encode(pets)
        try? encodedPets?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedPetData = try? Data(contentsOf: archiveURL),
           let petsDecoded = try? propertyListDecoder.decode([Pet].self, from: retrievedPetData) {
            pets = petsDecoded
        }
    }
}
