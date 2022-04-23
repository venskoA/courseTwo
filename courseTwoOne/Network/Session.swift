import UIKit

// MARK: Singleton class
class Session {
    static let shared = Session()

    var token: String?
    var userId: Int?

    private init() {}
}
