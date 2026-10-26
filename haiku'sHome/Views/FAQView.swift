//
//  FAQView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 09/11/2023.
//

import SwiftUI

struct FAQView: View {
    
    
    
    
    var body: some View {
        NavigationStack {
            List {
                
                NavigationLink {
                    FoundCatResource()
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("I found a cat that needs help!")
                }
                
                
                NavigationLink {
                    FeedingStraysResource()
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("Feeding Stray Cats")
                }
                .navigationBarTitleDisplayMode(.large)
                
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Resources")
        }
        //.navigationBarTitleDisplayMode(.large)
       
        
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
