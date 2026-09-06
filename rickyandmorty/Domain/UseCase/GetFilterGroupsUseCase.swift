import Factory
import Foundation

class GetFilterGroupsUseCase {

    func execute() -> [FilterGroup] {
        [
            FilterGroup(
                id: FilterConstants.speciesGroupId,
                options: [
                    FilterOption(id: FilterConstants.speciesHuman),
                    FilterOption(id: FilterConstants.speciesAlien),
                    FilterOption(id: FilterConstants.speciesRobot),
                    FilterOption(id: FilterConstants.speciesAnimal),
                    FilterOption(id: FilterConstants.speciesDisease),
                    FilterOption(id: FilterConstants.speciesCronenberg),
                    FilterOption(id: FilterConstants.speciesPoopybutthole),
                    FilterOption(id: FilterConstants.speciesMythological),
                    FilterOption(id: FilterConstants.unknown)
                ]
            ),
            FilterGroup(
                id: FilterConstants.genderGroupId,
                options: [
                    FilterOption(id: FilterConstants.genderFemale),
                    FilterOption(id: FilterConstants.genderMale),
                    FilterOption(id: FilterConstants.genderGenderless),
                    FilterOption(id: FilterConstants.unknown)
                ]
            ),
            FilterGroup(
                id: FilterConstants.statusGroupId,
                options: [
                    FilterOption(id: FilterConstants.statusAlive),
                    FilterOption(id: FilterConstants.statusDead),
                    FilterOption(id: FilterConstants.unknown)
                ]
            )
        ]
    }
}
