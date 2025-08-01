import Foundation

class ColorStorage {
    static let shared = ColorStorage()
    private let key = "savedColors"

    func save(color: ColorModel) {
        var existingColors = fetchColors()
        existingColors.append(color)

        if let data = try? JSONEncoder().encode(existingColors) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func fetchColors() -> [ColorModel] {
        if let data = UserDefaults.standard.data(forKey: key),
           let colors = try? JSONDecoder().decode([ColorModel].self, from: data) {
            return colors
        }
        return []
    }

    func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
