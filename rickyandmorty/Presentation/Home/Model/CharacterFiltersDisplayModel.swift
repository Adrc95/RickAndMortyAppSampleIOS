struct CharacterFiltersDisplayModel: Equatable {
    var species: String? = nil
    var gender: String? = nil
    var status: String? = nil

    var hasActiveFilters: Bool {
        species != nil || gender != nil || status != nil
    }
}
