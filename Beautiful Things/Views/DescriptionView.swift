//
//  DescriptionView.swift
//  Beautiful Things
//
//  The view showing details of the model such as description, author, and license. Presented as a .sheet in CardView.
//

import SwiftUI

struct DescriptionView: View {
    // The beautiful thing being selected in CardView.
    var beautifulThing: BeautifulThing
    
    // Binding variable to keep track of .sheet state.
    @Binding var showSheet: Bool
    
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
    }
}


