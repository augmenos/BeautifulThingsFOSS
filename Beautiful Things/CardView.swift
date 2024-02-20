//
//  GridView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct CardView: View {
    var beautifulThing: BeautifulThing
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(beautifulThing.category)
                    Spacer()
                    
                    Button {
                        print("Button: Favorite")
                    } label: {
                        Image(systemName: "star.circle.fill")
                    }
                    .symbolRenderingMode(.hierarchical)
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(beautifulThing.subtitle)
                        Text(beautifulThing.title)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(beautifulThing.year)
                    }
                }
            }
            .padding(30)
            .frame(width: 300, height: 300)
            .glassBackgroundEffect()
            
            if let fileURL = URL(string: beautifulThing.filename) {
                Model3D(url: fileURL) { model in
                    model
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    if let imageURL = URL(string: beautifulThing.imageURL) {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 175, height: 175)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 175, height: 175)
            } else {
                if let imageURL = URL(string: beautifulThing.imageURL) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 175, height: 175)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            
        }
    }
}