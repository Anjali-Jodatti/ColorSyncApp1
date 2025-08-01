import Foundation

struct ColorModel: Codable, Identifiable {
    var id = UUID()
    var hexCode: String
    var timestamp: Date

    enum CodingKeys: String, CodingKey {
        case hexCode, timestamp
    }
}
