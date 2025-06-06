import SwiftUI

struct CharacterDetailView: View {
    var character: Character

    var body: some View {
        Text(character.name)
            .navigationTitle(character.name)
    }
}

#Preview {
    let character = Character(name: "Preview", life: 2)
    return CharacterDetailView(character: character)
}
