//
//  UserManager.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 24/08/2023.
//

import Foundation
import FirebaseAuth
import Firebase

class UserManager: ObservableObject {
    
    @Published var user: User?
    private var db = Firestore.firestore()
    
    
    func createUser(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            
            if let authResult = authResult {
                let userID = authResult.user.uid
                
                Firestore.firestore().collection("users").document(userID).setData([
                    "firstName": firstName,
                    "lastName": lastName,
                ]) { error in
                    if let error = error {
                        print(error)
                        completion(.failure(error))
                    } else {
                        completion(.success(userID))
                    }
                }
            }
        }
    }
    
    func fetchUser(withUserID documentID: String) {
        
        let collectionRef = db.collection("users")
        
        collectionRef.document(documentID).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let document = document, document.exists {
                let data = document.data()
                if let firstName = data?["firstName"] as? String, let lastName = data?["lastName"] as? String {
                    let fetchedUser = User(firstName: firstName, lastName: lastName)
                    self.user = fetchedUser
                } else {
                    print("First name or last name not found in document")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    func deleteAccount(userID: String) {
        
        
        
        self.db.collection("users").document(userID).delete() { err in
          if let err = err {
            print("Error removing document: \(err)")
          } else {
            print("Document successfully removed!")
          }
        }
        
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened. yikes
            } else {
                //yay.
            }
        }
        
        
        
    }
    
    func signOut(userID: String) -> String {
        
        //sign out. if successful, change current userid to empty. if fail, do nothing
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            return ""

        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return userID
        }
    }
}
