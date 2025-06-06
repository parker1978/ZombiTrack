//
//  ActionsScreen.swift
//  ZombiTrack
//
//  Created by Stephen Parker on 6/6/25.
//

import SwiftUI
import SwiftData

struct ActionsScreen: View {
    @Query(sort: \Game.startedAt, order: .reverse) var games: [Game]

    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink(game.name) {
//                        GameDetailView(game: game)
                    }
                }
            }
            .navigationTitle("Actions")
            .toolbar {
//                NavigationLink("New Game", destination: NewGameView())
            }
        }
    }
}
