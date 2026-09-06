import SwiftUICore

enum FilterOptionDisplayModel {
    case species(Species)
    case gender(Gender)
    case status(Status)

    var label: String {
        switch self {
        case .species(let species): species.label
        case .gender(let gender): gender.label
        case .status(let status): status.label
        }
    }

    var filterValue: String? {
        switch self {
        case .species(let species): species.toFilterValue
        case .gender(let gender): gender.toFilterValue
        case .status(let status): status.toFilterValue
        }
    }

    enum Species {
        case human
        case alien
        case robot
        case animal
        case disease
        case cronenberg
        case poopybutthole
        case mythologicalCreature
        case unknown

        var label: String {
            switch self {
            case .human:
                "filter_species_human".getString()
            case .alien:
                "filter_species_alien".getString()
            case .robot:
                "filter_species_robot".getString()
            case .animal:
                "filter_species_animal".getString()
            case .disease:
                "filter_species_disease".getString()
            case .cronenberg:
                "filter_species_cronenberg".getString()
            case .poopybutthole:
                "filter_species_poopybutthole".getString()
            case .mythologicalCreature:
                "filter_species_mythological_creature".getString()
            case .unknown:
                "filter_species_unknown".getString()
            }
        }
    }

    enum Gender {
        case female
        case male
        case genderless
        case unknown

        var label: String {
            switch self {
            case .female:
                "filter_gender_female".getString()
            case .male:
                "filter_gender_male".getString()
            case .genderless:
                "filter_gender_genderless".getString()
            case .unknown:
                "filter_gender_unknown".getString()
            }
        }
    }

    enum Status {
        case alive
        case dead
        case unknown

        var label: String {
            switch self {
            case .alive:
                "filter_status_alive".getString()
            case .dead:
                "filter_status_dead".getString()
            case .unknown:
                "filter_status_unknown".getString()
            }
        }
    }
}

extension FilterOptionDisplayModel: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .species(let species):
            hasher.combine("species")
            hasher.combine(species)
        case .gender(let gender):
            hasher.combine("gender")
            hasher.combine(gender)
        case .status(let status):
            hasher.combine("status")
            hasher.combine(status)
        }
    }

    static func == (lhs: FilterOptionDisplayModel, rhs: FilterOptionDisplayModel) -> Bool {
        switch (lhs, rhs) {
        case (.species(let a), .species(let b)): a == b
        case (.gender(let a), .gender(let b)): a == b
        case (.status(let a), .status(let b)): a == b
        default: false
        }
    }
}

extension FilterOptionDisplayModel.Species: Hashable {
    var toFilterValue: String {
        switch self {
        case .human: "Human"
        case .alien: "Alien"
        case .robot: "Robot"
        case .animal: "Animal"
        case .disease: "Disease"
        case .cronenberg: "Cronenberg"
        case .poopybutthole: "Poopybutthole"
        case .mythologicalCreature: "Mythological Creature"
        case .unknown: "unknown"
        }
    }
}

extension FilterOptionDisplayModel.Gender: Hashable {
    var toFilterValue: String {
        switch self {
        case .female: "Female"
        case .male: "Male"
        case .genderless: "Genderless"
        case .unknown: "unknown"
        }
    }
}

extension FilterOptionDisplayModel.Status: Hashable {
    var toFilterValue: String {
        switch self {
        case .alive: "Alive"
        case .dead: "Dead"
        case .unknown: "unknown"
        }
    }
}
