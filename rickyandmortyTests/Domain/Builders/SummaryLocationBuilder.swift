import Foundation
@testable import rickyandmorty

final class SummaryLocationBuilder {
    var id: Int = 1
    var name: String = "Earth (C-137)"

    func withId(_ id: Int) -> Self { self.id = id; return self }
    func withName(_ name: String) -> Self { self.name = name; return self }

    func build() -> SummaryLocation {
        SummaryLocation(id: id, name: name)
    }
}

func makeSummaryLocation(_ block: (SummaryLocationBuilder) -> Void = { _ in }) -> SummaryLocation {
    let builder = SummaryLocationBuilder()
    block(builder)
    return builder.build()
}