import FirebaseFirestore
import Combine

/// Handles all Firestore writes and reads.
class FirebaseManager {
    static let shared = FirebaseManager()
    private init() {}

    private let db = Firestore.firestore()

    /// Upload one color to the “colors” collection.
    func upload(color: ColorModel, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = [
            "hexCode": color.hexCode,
            "timestamp": Timestamp(date: color.timestamp)
        ]

        db.collection("colors").addDocument(data: data) { error in
            completion(error)
        }
    }

    /// Push every locally-saved color and clear local storage when done.
    func syncPendingColors() {
        let pending = ColorStorage.shared.fetchColors()
        guard !pending.isEmpty else { return }

        let group = DispatchGroup()

        for color in pending {
            group.enter()
            upload(color: color) { _ in
                group.leave()
            }
        }

        group.notify(queue: .main) {
            // All uploads finished—clear local cache
            ColorStorage.shared.clearAll()
        }
    }
}
