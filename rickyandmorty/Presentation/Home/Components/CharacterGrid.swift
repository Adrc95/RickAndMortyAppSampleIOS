import SwiftUI

struct CharacterGrid: View {
    let characters: [CharacterDisplayModel]
    var isLoadingNextPage: Bool = false
    var showFavourite: Bool = true
    var scrollResetToken: Int = 0
    var onCharacterTap: (Int) -> Void
    var onFavouriteToggle: (Int) -> Void
    var onScrollToBottom: (() -> Void)?

    private let columns = [
        GridItem(.adaptive(minimum: 170), spacing: 16)
    ]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(characters) { character in
                        CharacterCard(
                            character: character,
                            showFavourite: showFavourite,
                            onTap: { onCharacterTap(character.id) },
                            onFavouriteToggle: { onFavouriteToggle(character.id) }
                        )
                        .id(character.id)
                        .onAppear {
                            if character.id == characters.last?.id {
                                onScrollToBottom?()
                            }
                        }
                    }
                }
                .padding()

                if isLoadingNextPage {
                    ProgressView()
                        .padding()
                }
            }
            .onChange(of: scrollResetToken) { _, _ in
                guard let firstID = characters.first?.id else { return }
                withAnimation {
                    proxy.scrollTo(firstID, anchor: .top)
                }
            }
        }
    }
}

#Preview {
    CharacterGrid(
        characters: [
            CharacterDisplayModel(
                id: 1, name: "Rick", status: .alive, species: "Human", type: "", gender: "Male",
                origin: SummaryLocation(id: 1, name: "Earth"), location: SummaryLocation(id: 2, name: "Mars"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episodeIds: [1]
            )
        ],
        onCharacterTap: { _ in },
        onFavouriteToggle: { _ in }
    )
}
