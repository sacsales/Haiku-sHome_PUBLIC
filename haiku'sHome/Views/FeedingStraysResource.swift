//
//  FeedingStraysResource.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 28/12/2023.
//

import SwiftUI

struct FeedingStraysResource: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading)  {
                Text("""
•    Please only feed DRY CAT food
•    Please do not feed wet cat food, raw meat, mince, chicken, fish, bones, bread, etc. These foods can be very dangerous for a cat’s health can make them sick.
•    Please only give fresh, plain water to drink, NOT milk. Milk is very bad for a cat’s stomach.

Thank you for your kind concern for stray cats.

""")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .navigationBarTitle("Feeding Stray Cats")
        }
    }
}

#Preview {
    FeedingStraysResource()
}
