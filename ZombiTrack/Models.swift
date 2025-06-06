import Foundation
import SwiftData

enum ActionType: String, Codable, CaseIterable {
    // default action
    case action
    case combat
    case melee
    case ranged
    case move
    case search
}

enum SkillLevel: String, Codable, CaseIterable {
    case blue
    case orange
    case red
}

@Model
final class Character {
    @Attribute(.unique) var id: UUID
    var name: String
    var life: Int
    var notes: String
    var isFavorite: Bool
    var createdAt: Date
    var updatedAt: Date
    
    @Relationship(deleteRule: .cascade) var skills: [CharacterSkill] = []
    @Relationship(deleteRule: .cascade) var gameCharacters: [GameCharacter] = []
    
    init(id: UUID = UUID(), name: String, life: Int, notes: String = "", isFavorite: Bool = false, createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.life = life
        self.notes = notes
        self.isFavorite = isFavorite
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

@Model
final class Skill {
    @Attribute(.unique) var id: UUID
    var name: String
    var skillDesc: String
    
    @Relationship(deleteRule: .cascade) var characterSkills: [CharacterSkill] = []
    
    init(id: UUID = UUID(), name: String, skillDesc: String) {
        self.id = id
        self.name = name
        self.skillDesc = skillDesc
    }
}

@Model
final class CharacterSkill {
    @Attribute(.unique) var id: UUID
    @Relationship(inverse: \Character.skills) var character: Character?
    @Relationship(inverse: \Skill.characterSkills) var skill: Skill?
    var position: Int
    var color: SkillLevel
    
    init(id: UUID = UUID(), character: Character? = nil, skill: Skill? = nil, position: Int, color: SkillLevel) {
        self.id = id
        self.character = character
        self.skill = skill
        self.position = position
        self.color = color
    }
}

@Model
final class Action {
    @Attribute(.unique) var id: UUID
    var type: ActionType
    
    @Relationship(deleteRule: .cascade) var logs: [GameActionLog] = []
    
    init(id: UUID = UUID(), type: ActionType) {
        self.id = id
        self.type = type
    }
}

@Model
final class Game {
    @Attribute(.unique) var id: UUID
    var name: String
    var startedAt: Date
    var endedAt: Date?
    var isFinished: Bool
    var notes: String
    
    @Relationship(deleteRule: .cascade) var characters: [GameCharacter] = []
    
    init(id: UUID = UUID(), name: String, startedAt: Date = Date(), endedAt: Date? = nil, isFinished: Bool = false, notes: String = "") {
        self.id = id
        self.name = name
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.isFinished = isFinished
        self.notes = notes
    }
}

@Model
final class GameCharacter {
    @Attribute(.unique) var id: UUID
    @Relationship(inverse: \Game.characters) var game: Game?
    @Relationship(inverse: \Character.gameCharacters) var character: Character?
    var startingXP: Int
    var currentXP: Int
    var lifeRemaining: Int
    var notes: String
    var createdAt: Date
    var updatedAt: Date
    
    @Relationship(deleteRule: .cascade) var logs: [GameActionLog] = []
    
    init(id: UUID = UUID(), game: Game? = nil, character: Character? = nil, startingXP: Int, currentXP: Int, lifeRemaining: Int, notes: String = "", createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.game = game
        self.character = character
        self.startingXP = startingXP
        self.currentXP = currentXP
        self.lifeRemaining = lifeRemaining
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

@Model
final class GameActionLog {
    @Attribute(.unique) var id: UUID
    @Relationship(inverse: \GameCharacter.logs) var gameCharacter: GameCharacter?
    @Relationship(inverse: \Action.logs) var action: Action?
    var timestamp: Date
    var notes: String
    var round: Int
    
    init(id: UUID = UUID(), gameCharacter: GameCharacter? = nil, action: Action? = nil, timestamp: Date = Date(), notes: String = "", round: Int = 0) {
        self.id = id
        self.gameCharacter = gameCharacter
        self.action = action
        self.timestamp = timestamp
        self.notes = notes
        self.round = round
    }
}
