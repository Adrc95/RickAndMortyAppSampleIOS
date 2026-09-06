import Foundation

enum MockUIFixtures {

    static func install() {
        MockURLProtocol.mockData = [
            "/character": charactersResponseJSON,
            "/location/1": location1JSON,
            "/location/3": location3JSON,
            "/episode/1": episode1JSON,
            "/episode/2": episode2JSON
        ]

        MockURLProtocol.requestHandler = { request in
            let path = request.url?.path ?? ""
            let grouped = groupPath(path)

            let data: Data
            switch grouped {
            case "/character":
                data = fixture(for: "/character", request: request)
            case "/character/" where request.url!.pathComponents.count >= 3:
                data = characterDetailJSON
            case "/location/1":
                data = Data(location1JSONString.utf8)
            case "/location/3":
                data = Data(location3JSONString.utf8)
            case "/episode/1":
                data = episodesArray([episode1JSONString])
            case "/episode/2":
                data = episodesArray([episode2JSONString])
            case "/episode" where request.url!.query != nil:
                data = Data(episodesBatchJSONString.utf8)
            default:
                data = Data("{}".utf8)
            }

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
    }

    static func reset() {
        MockURLProtocol.requestHandler = nil
        MockURLProtocol.mockData = [:]
    }

    private static func groupPath(_ path: String) -> String {
        let components = path.split(separator: "/").map(String.init).filter { !$0.isEmpty }
        if components.count >= 3, components[0] == "api", components[1] == "character" {
            return "/character/"
        }
        if components.count >= 3, components[1] == "character" {
            return "/character/"
        }
        if components.count >= 3, components[0] == "api", components[1] == "location" {
            return "/location/\(components[2])"
        }
        if components.count >= 3, components[1] == "location" {
            return "/location/\(components[2])"
        }
        if components.count >= 3, components[0] == "api", components[1] == "episode" {
            return "/episode/\(components[2])"
        }
        if components.count >= 3, components[1] == "episode" {
            return "/episode/\(components[2])"
        }
        if path.hasSuffix("/character") || path.hasSuffix("/api/character") {
            return "/character"
        }
        return path
    }

    private static func fixture(for key: String, request: URLRequest) -> Data {
        let query = request.url?.query ?? ""
        if query.contains("name=") || query.contains("species=") || query.contains("gender=") || query.contains("status=") {
            return Data(searchResponseJSONString.utf8)
        }
        if query.contains("page=2") {
            return Data(charactersPage2JSONString.utf8)
        }
        return Data(charactersResponseJSONString.utf8)
    }

    static let charactersResponseJSONString = """
    {
      "info": { "count": 1, "pages": 1, "next": null, "prev": null },
      "results": [\(characterJSONString)]
    }
    """

    static let charactersPage2JSONString = """
    {
      "info": { "count": 2, "pages": 1, "next": null, "prev": null },
      "results": [\(characterJSONString)]
    }
    """

    static let searchResponseJSONString = """
    {
      "info": { "count": 1, "pages": 1, "next": null, "prev": null },
      "results": [\(characterJSONString)]
    }
    """

    static let characterJSONString = """
    {
      "id": 1,
      "name": "Rick Sanchez",
      "status": "Alive",
      "species": "Human",
      "type": "",
      "gender": "Male",
      "origin": { "name": "Earth (C-137)", "url": "https://rickandmortyapi.com/api/location/1" },
      "location": { "name": "Citadel of Ricks", "url": "https://rickandmortyapi.com/api/location/3" },
      "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      "episode": ["https://rickandmortyapi.com/api/episode/1"],
      "url": "https://rickandmortyapi.com/api/character/1",
      "created": "2017-11-04T18:48:46.250Z"
    }
    """

    static let characterDetailJSON: Data = {
        Data(characterJSONString.utf8)
    }()

    static let charactersResponseJSON: Data = {
        Data(charactersResponseJSONString.utf8)
    }()

    static let location1JSONString = """
    {
      "id": 1,
      "name": "Earth (C-137)",
      "type": "Planet",
      "dimension": "Dimension C-137",
      "residents": [],
      "url": "https://rickandmortyapi.com/api/location/1",
      "created": "2017-11-10T12:42:04.162Z"
    }
    """

    static let location1JSON: Data = {
        Data(location1JSONString.utf8)
    }()

    static let location3JSONString = """
    {
      "id": 3,
      "name": "Citadel of Ricks",
      "type": "Space station",
      "dimension": "unknown",
      "residents": [],
      "url": "https://rickandmortyapi.com/api/location/3",
      "created": "2017-11-10T13:08:13.191Z"
    }
    """

    static let location3JSON: Data = {
        Data(location3JSONString.utf8)
    }()

    static let episode1JSONString = """
    {
      "id": 1,
      "name": "Pilot",
      "air_date": "December 2, 2013",
      "episode": "S01E01",
      "characters": [],
      "url": "https://rickandmortyapi.com/api/episode/1",
      "created": "2017-11-10T12:56:33.798Z"
    }
    """

    static let episode1JSON: Data = {
        Data(episode1JSONString.utf8)
    }()

    static let episode2JSONString = """
    {
      "id": 2,
      "name": "Lawnmower Dog",
      "air_date": "December 9, 2013",
      "episode": "S01E02",
      "characters": [],
      "url": "https://rickandmortyapi.com/api/episode/2",
      "created": "2017-11-10T12:56:33.916Z"
    }
    """

    static let episode2JSON: Data = {
        Data(episode2JSONString.utf8)
    }()

    static let episodesBatchJSONString = """
    [
      \(episode1JSONString),
      \(episode2JSONString)
    ]
    """

    private static func episodesArray(_ elements: [String]) -> Data {
        Data("[\(elements.joined(separator: ","))]".utf8)
    }
}
