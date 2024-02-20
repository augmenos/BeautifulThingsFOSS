//
//  NavigationView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        HStack {
            Button {
                print("Button: All")
            } label: {
                Text("All")
                    .frame(width: 60)
            }
            .glassBackgroundEffect()
            .padding(.trailing, 10)
            
            Button {
                print("Button: All")
            } label: {
                Text("New")
                    .frame(width: 60)
            }
            .glassBackgroundEffect()
            .padding(.trailing, 10)

            Button {
                print("Button: All")
            } label: {
                Text("Culture")
                    .frame(width: 60)
            }
            .glassBackgroundEffect()
            .padding(.trailing, 10)

            Button {
                print("Button: All")
            } label: {
                Text("Tech")
                    .frame(width: 60)
            }
            .glassBackgroundEffect()
            .padding(.trailing, 10)

            Button {
                print("Button: All")
            } label: {
                Text("Nature")
                    .frame(width: 60)
            }
            .glassBackgroundEffect()
            .padding(.trailing, 10)

            Button {
                print("Button: All")
            } label: {
                Text("Other")
                    .frame(width: 60)
            }
            .glassBackgroundEffect()
            .padding(.trailing, 10)
            
            Button {
                print("Button: All")
            } label: {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            .glassBackgroundEffect()
            .padding(.leading, 20)

        }
    }
}

#Preview {
    NavigationView()
}
