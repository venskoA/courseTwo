//
//  OutputNewsModel.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 16.03.22.
//

import Foundation

struct OutputNewsModel {
    var cells: [Cell]

    struct Cell {
        var postId: Int
        var avatar: String
        var date: Int?
        var nameGroup: String
//        var date: String
        var manualNews: String?
        var likes: Int?
        var comments: Int?
        var reply: Int?
        var browsing: Int?
        var photoAttachments: [String]?
    }

    struct FotoCellAttachment {
        var url: String?
    }
}
