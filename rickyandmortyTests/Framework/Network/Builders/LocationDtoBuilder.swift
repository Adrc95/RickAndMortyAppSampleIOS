import Foundation
@testable import rickyandmorty

final class LocationDtoBuilder {
    var id: Int = 1
    var name: String = "Earth (C-137)"
    var type: String = "Planet"
    var dimension: String = "Dimension C-137"
    var residents: [String] = [
        "https://rickandmortyapi.com/api/character/1",
        "https://rickandmortyapi.com/api/character/2",
        "https://rickandmortyapi.com/api/character/3"
    ]
    var url: String = "https://rickandmortyapi.com/api/location/1"
    var created: String = "2017-11-10T12:42:04.162Z"

    func withId(_ id: Int) -> Self { self.id = id; return self }
    func withName(_ name: String) -> Self { self.name = name; return self }
    func withType(_ type: String) -> Self { self.type = type; return self }
    func withDimension(_ dimension: String) -> Self { self.dimension = dimension; return self }
    func withResidents(_ residents: [String]) -> Self { self.residents = residents; return self }
    func withUrl(_ url: String) -> Self { self.url = url; return self }
    func withCreated(_ created: String) -> Self { self.created = created; return self }

    func build() -> LocationDto {
        LocationDto(
            id: id,
            name: name,
            type: type,
            dimension: dimension,
            residents: residents,
            url: url,
            created: created
        )
    }
}

func makeLocationDto(_ block: (LocationDtoBuilder) -> Void = { _ in }) -> LocationDto {
    let builder = LocationDtoBuilder()
    block(builder)
    return builder.build()
}