//
//  PetStruct.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 19/07/2023.
//

import Foundation
import PhotosUI
import SwiftUI
import FirebaseFirestoreSwift


enum Species: String, Codable, CaseIterable, Hashable {
        case cat
        case dog
        case bird
        case snake
        case other
    
    func stringValue() -> String {
        switch(self) {
        case .cat:
            return "Cat"
        case .dog:
            return "Dog"
        case .bird:
            return "Bird"
        case .snake:
            return "Snake"
        case .other:
            return "Other"
            
        }
    }
}

enum AgeRange: String, Codable, CaseIterable, Hashable {
    case baby
    case adult
    case senior
    
    func stringValue() -> String {
        switch(self) {
        case .baby:
            return "Baby"
        case .adult:
            return "Adult"
        case .senior:
            return "Senior"
            
        }
    }
}


struct Pet: Hashable, Codable, Identifiable {
    
    var id = UUID().uuidString
    var species: Species
    var name: String
    var age: AgeRange
    
    var desc: String
    var personality: String
    var notes: String
    
    var kidFriendly: Bool = false
    var social: Bool = false
    
    var location: String
    var isSaved: Bool = false
    var userID: String
    var image: String?
    
    var contact: String
    
    enum CodingKeys: String, CodingKey {
        case species
        case name
        case age
        
        case desc
        case personality
        case notes
        
        case kidFriendly
        case social
        
        case location
        case isSaved
        case userID
        case image
        case contact
    }
}
