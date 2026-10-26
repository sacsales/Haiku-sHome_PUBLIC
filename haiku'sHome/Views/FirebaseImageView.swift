//
//  FirebaseImageView.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 14/10/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct FirebaseImageView: View {
    // Firebase Storage reference
    let storage = Storage.storage()
    let storageReference: StorageReference
    let frame: CGFloat
    @State private var image: UIImage?

    init(imagePath: String, frameSize: CGFloat) {
        storageReference = storage.reference().child(imagePath)
        frame = frameSize
        
    }

    var body: some View {
        if let uiImage = image {
            Image(uiImage: uiImage)
                .resizable()
              //  .aspectRatio(contentMode: .fill)
                .scaledToFit()
                .mask(Circle())
                .frame(width: frame, height: frame)
                
                .padding(.trailing)
        } else {
            VStack {
                Text("Loading Image...")
                    .onAppear(perform: loadImage)
                
            }
            //.padding(.trailing)
        }
    }

    private func loadImage() {
        // Download image data from Firebase Storage
        storageReference.getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else {
                // Convert the data to UIImage
                if let imageData = data, let uiImage = UIImage(data: imageData) {
                    // Update the @State variable to trigger view update
                    image = uiImage
                }
            }
        }
    }
}


//struct FirebaseImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirebaseImageView(imagePath: "08D82E98-13DB-4CDC-B09E-283C44A99302.jpg")
//    }
//}
