//
//  TagView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 16/07/2023.
//

import SwiftUI

struct TagView: View {
    
    var tagText: String
    var color: Color
    var body: some View {
        
        ZStack (alignment: .leading) {
           
            Rectangle()
                .fill(color.opacity(0.8))
                .frame(width: 150, height: 35)
                .cornerRadius(12)
            HStack {
                Image(systemName: "number")
                Text("\(tagText)")
                    
            }
            .padding(.leading)
            .bold()
            .font(.footnote)

        }
        
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tagText: "Adult", color: .orange)
    }
}
