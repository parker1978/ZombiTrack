//
//  CharactersScreen.swift
//  ZombiTrack
//
//  Created by Stephen Parker on 6/6/25.
//

import SwiftUI
import SwiftData

struct CharactersScreen: View {
    @Query(sort: [SortDescriptor(\Character.isFavorite, order: .reverse), SortDescriptor(\Character.name)]) var characters: [Character]

    @State private var searchText = ""

    private var filteredCharacters: [Character] {
        guard !searchText.isEmpty else { return characters }
        let searchLower = searchText.lowercased()
        return characters.filter { character in
            character.name.lowercased().contains(searchLower) ||
            character.skills.contains { cs in
                cs.skill?.name.lowercased().contains(searchLower) ?? false
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink("Advanced Skill Search") {
                        Text("Coming Soon")
                            .navigationTitle("Advanced Search")
                    }
                }

                ForEach(filteredCharacters) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(character.name)
                                .font(.headline)
                            Text(character.skills.sorted { $0.position < $1.position }
                                    .compactMap { $0.skill?.name }
                                    .joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Characters")
            .searchable(text: $searchText, prompt: "Search by name or skill")
            .toolbar {
                NavigationLink("Add") {
                    NewCharacterView()
                }
            }
        }
    }
}
