import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ActionsScreen()
                .tabItem {
                    Label("Actions", systemImage: "bolt.fill")
                }
            CharactersScreen()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
