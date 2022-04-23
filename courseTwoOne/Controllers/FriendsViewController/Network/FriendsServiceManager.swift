import Foundation
import UIKit

class FriendsServiceManager {
    private var service = FriendsApiService()
    private var imageServise = ImageLoader()

        func loadFriends(comletion: @escaping([FriendItems]) -> Void) {
        service.loadFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friend):
                let section = friend.response.items
                comletion(section)
            case .failure(_):
                return
            }
        }
    }

    func loadImage(url: String, comletion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: url) else { return }
        imageServise.loadImage(url: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                comletion(image)
            case .failure(let error):
                debugPrint("Error \(error.localizedDescription)")
            }
        }
    }
}

