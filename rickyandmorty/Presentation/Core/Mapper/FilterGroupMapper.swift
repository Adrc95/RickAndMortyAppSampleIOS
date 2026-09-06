import SwiftUI

extension FilterGroup {
    func toDisplayModel() -> FilterGroupDisplayModel {
        FilterGroupDisplayModel(
            id: id,
            title: LocalizedStringKey(id),
            options: options.map { $0.toDisplayModel() }
        )
    }
}

extension FilterOption {
    func toDisplayModel() -> FilterOptionDisplayModel {
        switch id.lowercased() {
        case FilterConstants.speciesHuman.lowercased(): .species(.human)
        case FilterConstants.speciesAlien.lowercased(): .species(.alien)
        case FilterConstants.speciesRobot.lowercased(): .species(.robot)
        case FilterConstants.speciesAnimal.lowercased(): .species(.animal)
        case FilterConstants.speciesDisease.lowercased(): .species(.disease)
        case FilterConstants.speciesCronenberg.lowercased(): .species(.cronenberg)
        case FilterConstants.speciesPoopybutthole.lowercased(): .species(.poopybutthole)
        case FilterConstants.speciesMythological.lowercased(): .species(.mythologicalCreature)
        case FilterConstants.genderFemale.lowercased(): .gender(.female)
        case FilterConstants.genderMale.lowercased(): .gender(.male)
        case FilterConstants.genderGenderless.lowercased(): .gender(.genderless)
        case FilterConstants.statusAlive.lowercased(): .status(.alive)
        case FilterConstants.statusDead.lowercased(): .status(.dead)
        default: .species(.unknown)
        }
    }
}
