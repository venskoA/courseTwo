import Foundation

struct FriendsVK: Decodable {
    let response: ResponseFriends
}

struct ResponseFriends: Decodable {
    let count: Int
    let items: [FriendItems]
}

struct FriendItems: Decodable {
    let id: Int
    let firstName, lastName: String
    let photo50: String

    enum CodingCase: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case foto50 = "photo_50"
    }
}
