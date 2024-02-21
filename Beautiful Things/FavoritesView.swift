//
//  FavoritesView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        
        Text("Favorites")
        
        //        ScrollView {
        //            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 50) {
        //                ForEach(appModel.userFavorites) { beautifulThing in
        //                    CardView(beautifulThing: beautifulThing)
        //                }
        //            }
        //            .padding()
        //        }
        
    }
}
