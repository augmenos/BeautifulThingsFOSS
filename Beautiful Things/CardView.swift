//
//  GridView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI
import RealityKit

struct CardView: View {
    @Environment(AppModel.self) private var appModel
    @ObservedObject var beautifulThing: BeautifulThing
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(beautifulThing.category)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Spacer()
                    
                    Button {
                        //                        appModel.toggleFavorite(beautifulThing)
                    } label: {
                        Image(systemName: beautifulThing.isFavorited ? "star.fill" : "star")
                            .font(.system(size: 25))
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                    .symbolRenderingMode(.monochrome)
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(beautifulThing.subtitle)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(beautifulThing.title)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Image(systemName: "arrow.up.right")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 2)
                        Text(beautifulThing.year)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.bottom, 35)
            }
            .padding(30)
            .frame(width: 300, height: 300)
            .glassBackgroundEffect()
            
            if let fileURL = Bundle.main.url(forResource: "robot_walk_idle", withExtension: "usdz") {
                ARQuickLookView(fileURL: fileURL)
                    .frame(width: 300, height: 300)
            }
        }
    }
}
