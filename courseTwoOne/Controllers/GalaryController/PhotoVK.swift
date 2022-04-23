struct PhotoVK: Decodable {
    let response: ResponsePhoto
}

struct ResponsePhoto: Decodable {
    let count: Int
    let items: [PhotoItems]
}

struct PhotoItems: Decodable {
    let albumId: Int
    let data: Int
    let sizes: [PhotoSize]

    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case data
        case sizes
    }
}

struct PhotoSize: Decodable {
    let height: Int
    let url: String
    let type: String
}
