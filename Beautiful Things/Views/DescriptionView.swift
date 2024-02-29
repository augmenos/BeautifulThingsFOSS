//
//  DescriptionView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/23/24.
//

import SwiftUI
import SwiftSoup

struct DescriptionView: View {
    @Binding var showSheet: Bool
    var beautifulThing: BeautifulThing
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(beautifulThing.subtitle + " " + beautifulThing.title)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.top, 15)
                }
                
                ScrollView {
                    Text(beautifulThing.descriptionText)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    Text("Model based on \(beautifulThing.subtitle + " " + beautifulThing.title) by \(beautifulThing.modelAuthor)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Text("Licensed under \(beautifulThing.license)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .frame(alignment: .leading)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        print("Button: Close DescriptionView")
                        showSheet = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .font(.system(size: 40))
                    }
                    .clipShape(Circle())
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, 8)
                .padding(.trailing, 8)
                
                Spacer()
            }
        }
        .frame(width: 500, height: 300)
        .padding(30)
//        .onAppear {
//            fetchBeautifulThingInfo(beautifulThing: beautifulThing) { description, modelName, modelAuthor, license in
//                self.descriptionText = description
//                self.modelName = modelName
//                self.modelAuthor = modelAuthor
//                self.license = license
//            }
//        }
    }
}


