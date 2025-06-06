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
final class CharacterXP {
    @Attribute(.unique) var id: UUID
    @Relationship var character: Character?
    var xp: Int

    init(id: UUID = UUID(), character: Character? = nil, xp: Int) {
        self.id = id
        self.character = character
        self.xp = xp
    }
}

@Model
final class Skill {
    @Attribute(.unique) var id: UUID
    var name: String
    var skillDesc: String

    init(id: UUID = UUID(), name: String, skillDesc: String) {
        self.id = id
        self.name = name
        self.skillDesc = skillDesc
    }
}

@Model
final class CharacterSkill {
    @Attribute(.unique) var id: UUID
    @Relationship var character: Character?
    @Relationship var skill: Skill?
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

    init(id: UUID = UUID(), type: ActionType) {
        self.id = id
        self.type = type
    }
}

@Model
final class CharacterAction {
    @Attribute(.unique) var id: UUID
    @Relationship var character: Character?
    @Relationship var action: Action?
    var order: Int

    init(id: UUID = UUID(), character: Character? = nil, action: Action? = nil, order: Int) {
        self.id = id
        self.character = character
        self.action = action
        self.order = order
    }
}

@Model
final class ActionLog {
    @Attribute(.unique) var id: UUID
    @Relationship var character: Character?
    @Relationship var action: Action?
    var timestamp: Date
    var notes: String

    init(id: UUID = UUID(), character: Character? = nil, action: Action? = nil, timestamp: Date = Date(), notes: String = "") {
        self.id = id
        self.character = character
        self.action = action
        self.timestamp = timestamp
        self.notes = notes
    }
}
