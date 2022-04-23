import Foundation
import RealmSwift

struct GroupVK: Codable {
    let response: ResponseGroup
}

struct ResponseGroup: Codable {
    let count: Int
    let items: [GroupItems]
}

class GroupItems: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var type: String
    @objc dynamic var photo50: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case photo50 = "photo_50"
    }
}
