import SwiftUI

struct FilterBottomSheet: View {

    let filterGroups: [FilterGroupDisplayModel]
    let currentFilters: CharacterFiltersDisplayModel
    let onApply: (CharacterFiltersDisplayModel) -> Void
    let onClear: () -> Void

    @State private var selectedSpecies: String?
    @State private var selectedGender: String?
    @State private var selectedStatus: String?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    init(
        filterGroups: [FilterGroupDisplayModel],
        currentFilters: CharacterFiltersDisplayModel = CharacterFiltersDisplayModel(),
        onApply: @escaping (CharacterFiltersDisplayModel) -> Void,
        onClear: @escaping () -> Void
    ) {
        self.filterGroups = filterGroups
        self.currentFilters = currentFilters
        self.onApply = onApply
        self.onClear = onClear
        _selectedSpecies = State(initialValue: currentFilters.species)
        _selectedGender = State(initialValue: currentFilters.gender)
        _selectedStatus = State(initialValue: currentFilters.status)
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("filter_character".getString())
                .font(.interBold(size: 20))
                .padding(.top, 24)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            ScrollView {
                VStack(spacing: 24) {
                    ForEach(filterGroups, id: \.id) { group in
                        FilterSection(
                            title: group.title,
                            options: group.options,
                            selectedValue: binding(for: group.id),
                            groupId: group.id
                        )
                    }
                }
                .padding(.horizontal)
            }

            VStack(spacing: 8) {
                Button("apply_filters".getString()) {
                    onApply(CharacterFiltersDisplayModel(
                        species: selectedSpecies,
                        gender: selectedGender,
                        status: selectedStatus
                    ))
                }
                .foregroundColor(Color.themeBackground(colorScheme))
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color.themeOnSurface(colorScheme))
                .cornerRadius(12)

                Button("clear_filters".getString()) {
                    selectedSpecies = nil
                    selectedGender = nil
                    selectedStatus = nil
                    onClear()
                }
                .foregroundColor(Color.themeOnSurfaceVariant(colorScheme))
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .background(Color.themeSurfaceContainerLowest(colorScheme))
        .cornerRadius(16)
    }

    private func binding(for groupId: String) -> Binding<String?> {
        switch groupId {
        case FilterConstants.speciesGroupId:
            return $selectedSpecies
        case FilterConstants.genderGroupId:
            return $selectedGender
        case FilterConstants.statusGroupId:
            return $selectedStatus
        default:
            return $selectedSpecies
        }
    }
}

private struct FilterSection: View {
    let title: LocalizedStringKey
    let options: [FilterOptionDisplayModel]
    @Binding var selectedValue: String?
    let groupId: String

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.interSemiBold(size: 12))
                    .textCase(.uppercase)
                    .tracking(0.5)
                    .foregroundColor(.themeOnSurfaceVariant(colorScheme))

            FlowLayout(spacing: 8) {
                ForEach(options, id: \.self) { option in
                    let isSelected = selectedValue == option.filterValue
                    Button(action: {
                        selectedValue = (selectedValue == option.filterValue) ? nil : option.filterValue
                    }) {
                        Text(option.label)
                            .font(isSelected ? .interSemiBold(size: 14) : .interMedium(size: 14))
                            .foregroundColor(isSelected ? Color.themeBackground(colorScheme) : Color.themeOnSurface(colorScheme))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .frame(minHeight: 48)
                            .background(isSelected ? Color.themeOnSurface(colorScheme) : Color.themeSurfaceContainerLowest(colorScheme))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isSelected ? Color.themeOnSurface(colorScheme) : Color.themeOutlineVariant(colorScheme), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
