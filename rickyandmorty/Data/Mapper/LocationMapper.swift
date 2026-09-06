import Foundation

extension LocationDto {
    func toDomain() -> LocationDetail {
        LocationDetail(
            id: id,
            name: name,
            type: type,
            dimension: dimension,
            residentsCount: residents.count
        )
    }

    func toData() -> LocationData {
        LocationData(
            id: id,
            name: name,
            type: type,
            dimension: dimension,
            residentsCount: residents.count
        )
    }
}

extension LocationData {
    func toDomain() -> LocationDetail {
        LocationDetail(
            id: id,
            name: name,
            type: type,
            dimension: dimension,
            residentsCount: residentsCount
        )
    }
}
