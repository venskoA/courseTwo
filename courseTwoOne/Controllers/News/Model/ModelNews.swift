//
//  ModelNews.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 1.03.22.
//

import Foundation

struct ModelNews: Codable {
    let response: NewResponse
}

struct NewResponse: Codable {
    let items: [NewModelItem]
    let profiles: [InfoProfile]
    let groups: [InfoGroups]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}

struct NewModelItem: Codable {
    let sourseId: Int
    let date: Int?
    let text: String?
    let postId: Int?
    let comments: CommentsNews?
    let attachments: [ItemAttachment]?
    let views: ViewsCount?
    let likes: Likes?
    let reposts: Reposts?

    let photos: PhotoInItem?

    enum CodingKeys: String, CodingKey {
        case sourseId = "source_id"
        case date
        case text
        case postId = "post_id"
        case comments
        case attachments
        case views
        case likes
        case reposts

        case photos
    }
}

struct PhotoInItem: Codable {
    let items: [DataInItem]

    enum CodingKeys: CodingKey {
        case items
    }
}

struct DataInItem: Codable {
    let sizes: [SizePhotoNews]

    enum CodingKeys: CodingKey {
        case sizes
    }
}

struct CommentsNews: Codable {
    let canPost: Int
//    let groupsCanPost: Bool
    let count: Int

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
//        case groupsCanPost = "groups_can_post"
        case count
    }
}

struct ItemAttachment: Codable {
    let photo: PhotoNews?
    let video: VideNews?
}

struct PhotoNews: Codable {
    let id: Int
    let owberId: Int
    let sizes: [SizePhotoNews]

    enum CodingKeys: String, CodingKey {
        case id
        case owberId = "owner_id"
        case sizes
    }
}

struct SizePhotoNews: Codable {
    let url: String
    let type: SizeType

    enum SizeType: String, Codable {
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
    }
}

struct VideNews: Codable {
    let image: [VideoUrls]
    let width: Int
}

struct ViewsCount: Codable {
    let count: Int
}

struct VideoUrls: Codable {
    let url: String
    let height: Int
}

struct Likes: Codable {
    let count: Int
    let userlikes: Int?
    let canlike: Int?

    enum CodigKeys: String, CodingKey {
        case count
        case userlikes = "user_likes"
        case canlike = "can_like"
    }
}

struct Reposts: Codable {
    let count: Int
}

struct InfoProfile: Codable {
    let firstName: String
    let lastName: String
    let id: Int
    let photo100: String
    let online: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case id
        case photo100 = "photo_100"
        case online
    }
}


struct InfoGroups: Codable {
    let id: Int
    let name: String
    let photo100: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo100 = "photo_100"
    }
}
