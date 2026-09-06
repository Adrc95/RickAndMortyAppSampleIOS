import Foundation
@testable import rickyandmorty

final class SummaryLocationDtoBuilder {
    var name: String = "Earth (C-137)"
    var url: String = "https://rickandmortyapi.com/api/location/1"

    func withName(_ name: String) -> Self { self.name = name; return self }
    func withUrl(_ url: String) -> Self { self.url = url; return self }

    func build() -> SummaryLocationDto {
        SummaryLocationDto(name: name, url: url)
    }
}

func makeSummaryLocationDto(_ block: (SummaryLocationDtoBuilder) -> Void = { _ in }) -> SummaryLocationDto {
    let builder = SummaryLocationDtoBuilder()
    block(builder)
    return builder.build()
}