//
//  HorizontalImageScrollView.swift
//  PokemonApp
//
//  Created by Alfredo Fregoso on 18/12/24.
//

import SwiftUI

struct HorizontalImageScrollView: View {
    let imageUrls: [String] // Array of image URLs
       
       var body: some View {
           ScrollView(.horizontal) {
               HStack(spacing: 20) {
                   ForEach(imageUrls, id: \.self) { url in
                       if let imageUrl = URL(string: url) {
                           AsyncImage(url: imageUrl) { image in
                               image
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 125, height: 125)
                           } placeholder: {
                               ProgressView()
                           }
                       }
                   }
               }
               .padding(.horizontal)
           }
       }
}

#Preview {
    HorizontalImageScrollView(imageUrls: [])
}
