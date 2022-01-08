import UIKit

// MARK: Singleton class
class Session {

    private let shared = Session()

    var token: String = ""
    var userId: Int = 111

    private init() {}
}
