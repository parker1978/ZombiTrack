//
//  CharactersScreen.swift
//  ZombiTrack
//
//  Created by Stephen Parker on 6/6/25.
//

import SwiftUI
import SwiftData

struct CharactersScreen: View {
    @Query(sort: \Character.name) var characters: [Character]

    var body: some View {
        NavigationStack {
            List {
                ForEach(characters) { character in
                    NavigationLink(character.name) {
//                        CharacterDetailView(character: character)
                    }
                }
            }
            .navigationTitle("Characters")
            .toolbar {
//                NavigationLink("Add", destination: NewCharacterView())
            }
        }
    }
}
