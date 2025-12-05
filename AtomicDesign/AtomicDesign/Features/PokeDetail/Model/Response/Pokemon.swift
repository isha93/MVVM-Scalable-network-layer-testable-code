//
//  Pokemon.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import Foundation

struct PokemonDetail: Codable {
    let abilities: [AbilityEntry]?
    let baseExperience: Int?
    let cries: Cries?
    let forms: [NamedAPIResource]?
    let gameIndices: [GameIndex]?
    let height: Int?
    let heldItems: [HeldItem]?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [MoveEntry]?
    let name: String?
    let order: Int?
    let pastAbilities: [PastAbility]?
    let pastTypes: [String]?
    let species: NamedAPIResource?
    let sprites: Sprites?
    let stats: [StatEntry]?
    let types: [TypeEntry]?
    let weight: Int?

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case cries
        case forms
        case gameIndices = "game_indices"
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves
        case name
        case order
        case pastAbilities = "past_abilities"
        case pastTypes = "past_types"
        case species
        case sprites
        case stats
        case types
        case weight
    }
}

// MARK: - Abilities
struct AbilityEntry: Codable {
    let ability: NamedAPIResourceNullable?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// Sometimes ability can be null in "past_abilities"
struct NamedAPIResourceNullable: Codable {
    let name: String?
    let url: String?
}

struct Cries: Codable {
    let latest: String?
    let legacy: String?
}

struct GameIndex: Codable {
    let gameIndex: Int?
    let version: NamedAPIResource?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - Held Items
struct HeldItem: Codable {
    let item: NamedAPIResource?
    let versionDetails: [HeldVersionDetail]?

    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
}

struct HeldVersionDetail: Codable {
    let rarity: Int?
    let version: NamedAPIResource?
}

// MARK: - Moves
struct MoveEntry: Codable {
    let move: NamedAPIResource?
    let versionGroupDetails: [MoveVersionDetail]?

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct MoveVersionDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod: NamedAPIResource
    let order: Int?
    let versionGroup: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case order
        case versionGroup = "version_group"
    }
}

// MARK: - Past Abilities
struct PastAbility: Codable {
    let abilities: [AbilityEntry]
    let generation: NamedAPIResource
}

// MARK: - Stats & Types
struct StatEntry: Codable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct TypeEntry: Codable {
    let slot: Int
    let type: NamedAPIResource
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: OtherSprites?
    let versions: Versions?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other
        case versions
    }
}

struct OtherSprites: Codable {
    let dreamWorld: SpriteSet?
    let home: SpriteSet?
    let officialArtwork: SpriteSet?
    let showdown: SpriteSet?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
        case showdown
    }
}

struct SpriteSet: Codable {
    let frontDefault: String?
    let frontShiny: String?
    let frontFemale: String?
    let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - Versions (very deep structure of many generations)
struct Versions: Codable {
    // You can add the generations you need
}

// MARK: - General Named Resource
struct NamedAPIResource: Codable {
    let name: String
    let url: String
}

extension PokemonDetail {
    static func mock(
        id: Int = 1,
        name: String = "pikachu",
        height: Int? = 4,
        weight: Int? = 60,
        baseStat: Int = 90
    ) -> PokemonDetail {
        return PokemonDetail(
            abilities: [],
            baseExperience: nil,
            cries: nil,
            forms: nil,
            gameIndices: nil,
            height: height,
            heldItems: nil,
            id: id,
            isDefault: nil,
            locationAreaEncounters: nil,
            moves: nil,
            name: name,
            order: nil,
            pastAbilities: nil,
            pastTypes: nil,
            species: nil,
            sprites: nil,
            stats: [StatEntry(baseStat: baseStat, effort: 0, stat: .init(name: "hp", url: "example.com"))],
            types: nil,
            weight: weight
        )
    }
}

