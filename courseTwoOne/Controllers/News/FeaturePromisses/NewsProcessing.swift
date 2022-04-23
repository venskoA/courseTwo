//
//  NewsProcessing.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 3.04.22.
//

import Foundation

class NewsProcessing {
    enum NewsProcessingError: Error {
        case NewsProcessingErrorNotDataInModel
    }

    func proces(infoGroup: [InfoGroups],
                items: [NewModelItem],
                complition: @escaping (Result<OutputNewsModel, Error>) -> ()) {
        var outputNews = OutputNewsModel.Cell(postId: 0, avatar: "", nameGroup: "", photoAttachments: [])
        var arrOutputNews = OutputNewsModel(cells: [])

        items.forEach { item in
            if let text = item.text {
                outputNews.postId = item.sourseId
                outputNews.likes = item.likes?.count
                outputNews.comments = item.comments?.count
                outputNews.reply = item.reposts?.count
                outputNews.browsing = item.views?.count
                outputNews.manualNews = text
                outputNews.date = item.date

                infoGroup.forEach { index in
                    if item.sourseId == -index.id {
                        outputNews.avatar = index.photo100
                        outputNews.nameGroup = index.name
                    }
                }

                for itemu in items {
                    if item.sourseId == itemu.sourseId && itemu.photos != nil {
                        var arr = [String]()
                        for item in itemu.photos!.items {
                            for index in item.sizes {
                                if index.type == .y {
                                    arr.append(index.url)
                                }
                            }
                        }
                        outputNews.photoAttachments = arr
                    }
                }
                arrOutputNews.cells.append(outputNews)
            }
        }
        if arrOutputNews.cells.isEmpty == false {
            complition(.success(arrOutputNews))
        } else {
            complition(.failure(NewsProcessingError
                                    .NewsProcessingErrorNotDataInModel))
        }
    }
}
