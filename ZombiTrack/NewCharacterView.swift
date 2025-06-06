import SwiftUI
import SwiftData

struct NewCharacterView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var life = 3
    @State private var notes = ""
    @State private var isFavorite = false
    @State private var showDetails = false
    @State private var appear = false

    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.words)
                Toggle("Favorite", isOn: $isFavorite.animation())
                Stepper("Life: \(life)", value: $life, in: 1...5)
                DisclosureGroup(isExpanded: $showDetails.animation(.easeInOut)) {
                    TextField("Notes", text: $notes)
                        .textFieldStyle(.roundedBorder)
                } label: {
                    Label("More Details", systemImage: "chevron.down")
                        .font(.headline)
                }
            }
            .formStyle(.grouped)
            .opacity(appear ? 1 : 0)
            .animation(.easeInOut(duration: 0.4), value: appear)

            Button(action: save) {
                Text("Save")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(Capsule().fill(Color.accentColor))
                    .foregroundStyle(.white)
            }
            .padding()
            .scaleEffect(appear ? 1 : 0.5)
            .animation(.spring(), value: appear)
        }
        .navigationTitle("New Character")
        .onAppear { appear = true }
    }

    private func save() {
        let character = Character(name: name, life: life, notes: notes, isFavorite: isFavorite)
        modelContext.insert(character)
        dismiss()
    }
}

#Preview {
    NewCharacterView()
}
