import Foundation

struct Config: Decodable {
    static let shared = Config()
    
    let baseUrl: URL
    
    init() {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "json") else {
            fatalError("Could not find config.json")
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Could not read data from config.json")
        }

        var configFromData: Config {
            do {
                return try JSONDecoder().decode(Config.self, from: data)
            } catch {
                fatalError("Could not parse config.json: \(String(describing: error))")
            }
        }

        self = configFromData
    }
}
