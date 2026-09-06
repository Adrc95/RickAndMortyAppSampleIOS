import Foundation
@testable import rickyandmorty

final class LocationDataBuilder {
    var id: Int = 1
    var name: String = "Earth (C-137)"
    var type: String = "Planet"
    var dimension: String = "Dimension C-137"
    var residentsCount: Int = 27

    func withId(_ id: Int) -> Self { self.id = id; return self }
    func withName(_ name: String) -> Self { self.name = name; return self }
    func withType(_ type: String) -> Self { self.type = type; return self }
    func withDimension(_ dimension: String) -> Self { self.dimension = dimension; return self }
    func withResidentsCount(_ residentsCount: Int) -> Self { self.residentsCount = residentsCount; return self }

    func build() -> LocationData {
        LocationData(id: id, name: name, type: type, dimension: dimension, residentsCount: residentsCount)
    }
}

func makeLocationData(_ block: (LocationDataBuilder) -> Void = { _ in }) -> LocationData {
    let builder = LocationDataBuilder()
    block(builder)
    return builder.build()
}