import SwiftUI
import SwiftData

@main
struct ZombiTrackApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Character.self,
            CharacterXP.self,
            Skill.self,
            CharacterSkill.self,
            Action.self,
            CharacterAction.self,
            ActionLog.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
